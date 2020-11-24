//
//  BlogDetailVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 02/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class BlogDetailVC: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var descLbl: Label!
    
    var blogData = BlogModel.init([String : Any]())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDetails()
    }
    
    func setupDetails() {
        setImageBackgroundImage(imgView, blogData.get_single_media.url, IMAGE.PLACEHOLDER)
        titleLbl.text = blogData.title
        descLbl.attributedText = blogData.desc.html2AttributedString
        if let strDate = blogData.created_at.components(separatedBy: "T").first {
            let date = getDateFromDateString(date: strDate, format: "yyyy-MM-dd")
            dateLbl.text = getDateStringFromDate(date: date, format: "MMMM d, yyyy")
        }
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToShare(_ sender: Any) {
        AppDelegate().sharedDelegate().shareBlog(blogData)
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
