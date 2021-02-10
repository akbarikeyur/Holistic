//
//  StatisticsTabVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 24/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import Charts

class StatisticsTabVC: UIViewController, ChartViewDelegate {

    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var fromTxt: UITextField!
    @IBOutlet weak var toTxt: UITextField!
    @IBOutlet weak var totalLbl: Label!
    @IBOutlet weak var completedLbl: Label!
    @IBOutlet weak var missedLbl: Label!
    @IBOutlet weak var percentageLbl: Label!
    @IBOutlet weak var loyalPointLbl: Label!
    @IBOutlet weak var botomLbl: Label!
    
    var fromDate, toDate : Date?
    var missedTask = 0
    var completedTask = 0
    var totalTask = 0
    var arrStatistic = [StatisticModel]()
    
    var arrDates = [String]()
    var arrCompleted = [Int]()
    var arrMissed = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        chartView.delegate = self
        toDate = Date()
        fromDate = toDate?.addDays(daysToAdd: -7)
        fromTxt.text = getLocalDateStringFromDate(date: fromDate!, format: "dd-MM-yyyy")
        toTxt.text = getLocalDateStringFromDate(date: toDate!, format: "dd-MM-yyyy")
    }
    
    func setupDetails() {
        NotificationCenter.default.post(name: NSNotification.Name.init("UPDATE_LIFESTYLE_HEIGHT"), object: 680)
        serviceCallToGetStatistics()
    }

    func setupChartData() {
        totalLbl.text = String(totalTask)
        completedLbl.text = String(completedTask)
        missedLbl.text = String(missedTask)
        var botomPercentage = ""
        if(completedTask == 0 && missedTask == 0){
            percentageLbl.text = "0%"
            botomPercentage = "more"
            
        }else{
            let percentage = Int(completedTask * 100 / (completedTask + missedTask))
            percentageLbl.text = String(percentage) + "%"
            
            if percentage > 80 {
                botomPercentage = "100%"
            }else{
                botomPercentage = String(percentage + 20) + "%+"
            }
        }
        botomLbl.text = "You are almost towards a healthier lifestyle, next month try to achieve " + botomPercentage + " and earn points to redeem against vouchers"
        chartView.noDataText = "Task not found."
        
        arrDates = [String]()
        arrCompleted = [Int]()
        arrMissed = [Int]()
        for temp in  arrStatistic{
            arrDates.append(getLocalDateStringFromDate(date: getDateFromDateString(date: temp.date, format: "yyyy-MM-dd"), format: "d MMM"))
            arrCompleted.append(temp.completed)
            arrMissed.append(temp.missed)
        }
        
        chartView.legend.enabled = false;
         let xaxis = chartView.xAxis
         //xaxis.valueFormatter = axisFormatDelegate
         xaxis.drawGridLinesEnabled = true
         xaxis.labelPosition = .bottom
         xaxis.centerAxisLabelsEnabled = true
         xaxis.valueFormatter = IndexAxisValueFormatter(values:self.arrDates)
         xaxis.granularity = 1


         let leftAxisFormatter = NumberFormatter()
         leftAxisFormatter.maximumFractionDigits = 1

         let yaxis = chartView.leftAxis
         yaxis.spaceTop = 0.35
         yaxis.axisMinimum = 0
         yaxis.drawGridLinesEnabled = false

         chartView.rightAxis.enabled = false
        //axisFormatDelegate = self

         setChart()
    }
    
    func setChart() {
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []

        for i in 0..<self.arrDates.count {
            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(self.arrCompleted[i]))
            dataEntries.append(dataEntry)

            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: Double(self.arrMissed[i]))
            dataEntries1.append(dataEntry1)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Completed")
        chartDataSet.colors = [UIColor(red: 20/255, green: 122/255, blue: 214/255, alpha: 1)]
        chartDataSet.highlightEnabled = false
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Missed")
        chartDataSet1.colors = [UIColor(red: 236/255, green: 102/255, blue: 102/255, alpha: 1)]
        chartDataSet1.highlightEnabled = false
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        //chartDataSet.colors = ChartColorTemplates.colorful()
        //let chartData = BarChartData(dataSet: chartDataSet)

        let chartData = BarChartData(dataSets: dataSets)

        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"

        let groupCount = self.arrDates.count
        let startYear = 0


        chartData.barWidth = barWidth;
        chartView.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        chartView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)

        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        //chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        chartView.notifyDataSetChanged()

        chartView.data = chartData
        
        //background color
        // chartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)

        //chart animation
        chartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
    }
    
    @IBAction func clickToSelectFromDate(_ sender: Any) {
        if fromDate == nil {
            fromDate = Date()
        }
        DatePickerManager.shared.showPicker(title: "Select from date", selected: fromDate, min: nil, max: Date()) { (date, isCancel) in
            if !isCancel {
                self.fromDate = date
                self.fromTxt.text = getLocalDateStringFromDate(date: self.fromDate!, format: "dd-MM-yyyy")
                self.toDate = nil
                self.toTxt.text = ""
            }
        }
    }
    
    @IBAction func clickToSelectToDate(_ sender: Any) {
        if fromDate == nil {
            displayToast("Please select from date")
            return
        }
        if toDate == nil {
            toDate = Date()
        }
        DatePickerManager.shared.showPicker(title: "Select from date", selected: toDate, min: fromDate, max: Date()) { (date, isCancel) in
            if !isCancel {
                self.toDate = date
                self.toTxt.text = getLocalDateStringFromDate(date: self.toDate!, format: "dd-MM-yyyy")
                self.serviceCallToGetStatistics()
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StatisticsTabVC {
    
    func serviceCallToGetStatistics() {
        var param = [String : Any]()
        param["user_id"] = AppModel.shared.currentUser.id
        param["start_date"] = getDateStringFromDate(date: fromDate!, format: "yyyy-MM-dd")
        param["end_date"] = getDateStringFromDate(date: toDate!, format: "yyyy-MM-dd")
        printData(param)
        HomeAPIManager.shared.serviceCallToGetStatistics(param) { (dict) in
            self.missedTask = AppModel.shared.getIntValue(dict, "vMissedTask")
            self.completedTask = AppModel.shared.getIntValue(dict, "vCompletedTask")
            self.totalTask = AppModel.shared.getIntValue(dict, "vTotalTask")
            
            self.arrStatistic = [StatisticModel]()
            if let data = dict["data"] as? [[String : Any]] {
                for temp in data {
                    self.arrStatistic.append(StatisticModel.init(temp))
                }
            }
            self.setupChartData()
        }
    }
}
