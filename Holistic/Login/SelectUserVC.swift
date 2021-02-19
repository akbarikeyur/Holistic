//
//  SelectUserVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 18/02/21.
//  Copyright © 2021 Keyur Akbari. All rights reserved.
//

import UIKit

class SelectUserVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var arrUser = getCliniciaMemberData()
    var selectedUser = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToContinue(_ sender: Any) {
        setClinicUserId(arrUser[selectedUser].ID)
        AppDelegate().sharedDelegate().navigateToDashBoard()
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
extension SelectUserVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "SingleLableTVC", bundle: nil), forCellReuseIdentifier: "SingleLableTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUser.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SingleLableTVC = tblView.dequeueReusableCell(withIdentifier: "SingleLableTVC") as! SingleLableTVC
        let dict = arrUser[indexPath.row]
        cell.titleLbl.text = dict.Title! + " " + dict.FirstName! + " " + dict.LastName
        cell.selectBtn.isHidden = (selectedUser != indexPath.row)
        cell.seperateImgView.isHidden = false
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = indexPath.row
        tblView.reloadData()
    }
}
