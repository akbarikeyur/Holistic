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
    
    var fromDate, toDate : Date?
    var missedTask = 0
    var completedTask = 0
    var totalTask = 0
    var arrStatistic = [StatisticModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        chartView.delegate = self
        toDate = Date()
        fromDate = toDate?.addDays(daysToAdd: -7)
    }
    
    func setupDetails() {
        NotificationCenter.default.post(name: NSNotification.Name.init("UPDATE_LIFESTYLE_HEIGHT"), object: 668)
        serviceCallToGetStatistics()
    }

    func setupChartData() {
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false
        
        chartView.maxVisibleCount = 60
        
        let arrTaskTitle = ["Missed", "Completed"]
        var arrTaskValue = [Int]()
        arrTaskValue.append(missedTask)
        arrTaskValue.append(completedTask)
        
        totalLbl.text = String(totalTask)
        completedLbl.text = String(completedTask)
        missedLbl.text = String(missedTask)
        percentageLbl.text = String(Int(completedTask * 100 / (completedTask + missedTask))) + "%"
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        xAxis.labelCount = arrTaskTitle.count
        xAxis.valueFormatter = DayAxisValueFormatter(chart: chartView)
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = ""
        leftAxisFormatter.positiveSuffix = ""
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.labelCount = arrTaskValue.count
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 0.15
        leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
        
        let l = chartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .circle
        l.formSize = 9
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
//        chartView.legend = l

        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                  font: .systemFont(ofSize: 12),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: chartView.xAxis.valueFormatter!)
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker
        
        self.setDataCount(arrTaskTitle.count, range: UInt32(arrTaskValue.count))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let start = 1
        
        let yVals = (start..<start+count+1).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult))
            if arc4random_uniform(100) < 25 {
                return BarChartDataEntry(x: Double(i), y: val, icon: UIImage(named: "icon"))
            } else {
                return BarChartDataEntry(x: Double(i), y: val)
            }
        }
        
        var set1: BarChartDataSet! = nil
        if let set = chartView.data?.dataSets.first as? BarChartDataSet {
            set1 = set
            set1.replaceEntries(yVals)
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(entries: yVals, label: "The year 2017")
            set1.colors = ChartColorTemplates.material()
            set1.drawValuesEnabled = false
            
            let data = BarChartData(dataSet: set1)
            data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
            data.barWidth = 0.9
            chartView.data = data
        }
    }
    
    @IBAction func clickToSelectFromDate(_ sender: Any) {
        if fromDate == nil {
            fromDate = Date()
        }
        DatePickerManager.shared.showPicker(title: "Select from date", selected: fromDate, min: nil, max: Date()) { (date, isCancel) in
            if !isCancel {
                self.fromDate = date
                self.fromTxt.text = getDateStringFromDate(date: self.fromDate!, format: "dd-MM-yyyy")
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
                self.toTxt.text = getDateStringFromDate(date: self.toDate!, format: "dd-MM-yyyy")
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
