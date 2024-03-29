//
//  LoyalityDetailVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 19/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class LoyalityDetailVC: UIViewController {

    @IBOutlet weak var topImgView: UIImageView!
    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var descLbl: Label!
    @IBOutlet weak var codeLbl: Label!
    
    var offerData = OfferModel.init([String : Any]())
    var selectedImageIndex = 0
    var code = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDetails()
        codeLbl.text = code
    }
    
    func setupDetails() {
        setImageBackgroundImage(topImgView, offerData.get_single_offer_image.url, IMAGE.PLACEHOLDER)
        titleLbl.text = offerData.title
        descLbl.text = offerData.desc.html2String
        codeLbl.text = "******"
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToCopyCode(_ sender: Any) {
        copyClipboard(codeLbl.text!)
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

extension LoyalityDetailVC {
    func serviceCallToGetOfferCode() {
        var param = [String : Any]()
        param["offer_id"] = offerData.id
        param["user_id"] = AppModel.shared.currentUser.id
        param["points_spent"] = offerData.points_required
        printData(param)
        ProfileAPIManager.shared.serviceCallToGetOfferCode(param) { (dict) in
            
        }
    }
}
