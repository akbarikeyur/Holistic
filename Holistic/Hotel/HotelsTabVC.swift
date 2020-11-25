//
//  HotelsTabVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class HotelsTabVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet var exploreView: UIView!
    
    var arrHotel = [HotelModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        serviceCallToGetHotelList()
    }
    
    func setupDetails() {
        tblView.reloadData()
        if !isFirstHotelPopup() {
            displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: self.exploreView)
            setFirstHotelPopup(true)
        }        
    }

    //MARK:- Button click event
    @IBAction func clickToCloseExploreView(_ sender: Any) {
        exploreView.removeFromSuperview()
    }
    
    @IBAction func clickToExploreNow(_ sender: Any) {
        exploreView.removeFromSuperview()
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

//MARK:- Tableview Method
extension HotelsTabVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "HotelsListTVC", bundle: nil), forCellReuseIdentifier: "HotelsListTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHotel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HotelsListTVC = tblView.dequeueReusableCell(withIdentifier: "HotelsListTVC") as! HotelsListTVC
        cell.setupDetails(arrHotel[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : HotelDetailVC = STORYBOARD.HOTEL.instantiateViewController(withIdentifier: "HotelDetailVC") as! HotelDetailVC
        vc.hotelData = arrHotel[indexPath.row]
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- Service called
extension HotelsTabVC {
    func serviceCallToGetHotelList() {
        HotelAPIManager.shared.serviceCallToGetHotelList { (data, is_last) in
            self.arrHotel = [HotelModel]()
            for temp in data {
                self.arrHotel.append(HotelModel.init(temp))
            }
            self.tblView.reloadData()
        }
    }
}
