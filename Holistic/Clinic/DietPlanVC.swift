//
//  DietPlanVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 09/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class DietPlanVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var arrExpand = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension DietPlanVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "DietPlanTVC", bundle: nil), forCellReuseIdentifier: "DietPlanTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DietPlanTVC = tblView.dequeueReusableCell(withIdentifier: "DietPlanTVC") as! DietPlanTVC
        
        let index = arrExpand.firstIndex { (temp) -> Bool in
            temp == indexPath.row
        }
        if index == nil {
            cell.detailView.isHidden = true
            cell.expandBtn.isSelected = false
            cell.outerView.layer.borderColor = LightBorderColor.cgColor
        }else{
            cell.detailView.isHidden = false
            cell.expandBtn.isSelected = true
            cell.outerView.layer.borderColor = OrangeColor.cgColor
        }
        cell.expandBtn.tag = indexPath.row
        cell.expandBtn.addTarget(self, action: #selector(clickToExpand(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func clickToExpand(_ sender: UIButton) {
        let index = arrExpand.firstIndex { (temp) -> Bool in
            temp == sender.tag
        }
        if index == nil {
            arrExpand.append(sender.tag)
        }else{
            arrExpand.remove(at: index!)
        }
        tblView.reloadData()
    }
}
