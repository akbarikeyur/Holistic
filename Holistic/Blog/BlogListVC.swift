//
//  BlogListVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 02/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class BlogListVC: UIViewController {

    @IBOutlet weak var blogCV: UICollectionView!
    @IBOutlet weak var constraintHeightBlogCV: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constraintHeightTblView: NSLayoutConstraint!
    
    var arrBlogData = [BlogModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        registerCollectionView()
        registerTableViewMethod()
        serviceCallToGetBlogList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToNotification(_ sender: Any) {
        let vc : NotificationVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
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

//MARK:- CollectionView Method
extension BlogListVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        blogCV.register(UINib.init(nibName: "BlogListCVC", bundle: nil), forCellWithReuseIdentifier: "BlogListCVC")
        constraintHeightBlogCV.constant = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 270, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : BlogListCVC = blogCV.dequeueReusableCell(withReuseIdentifier: "BlogListCVC", for: indexPath) as! BlogListCVC
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc : BlogDetailVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "BlogDetailVC") as! BlogDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- Tableview Method
extension BlogListVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "BlogListTVC", bundle: nil), forCellReuseIdentifier: "BlogListTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBlogData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BlogListTVC = tblView.dequeueReusableCell(withIdentifier: "BlogListTVC") as! BlogListTVC
        cell.setupDetails(arrBlogData[indexPath.row])
        cell.shareBtn.tag = indexPath.row
        cell.shareBtn.addTarget(self, action: #selector(clickToShare(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : BlogDetailVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "BlogDetailVC") as! BlogDetailVC
        vc.blogData = arrBlogData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToShare(_ sender: UIButton) {
        AppDelegate().sharedDelegate().shareBlog(arrBlogData[sender.tag])
    }
}

//MARK:- Service call
extension BlogListVC {
    func serviceCallToGetBlogList() {
        BlogAPIManager.shared.serviceCallToGetBlogList { (data, last_page) in
            self.arrBlogData = [BlogModel]()
            for temp in data {
                self.arrBlogData.append(BlogModel.init(temp))
            }
            self.tblView.reloadData()
            self.constraintHeightTblView.constant = CGFloat(100 * self.arrBlogData.count)
        }
    }
}
