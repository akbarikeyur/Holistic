//
//  ProductTabVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 28/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ProductTabVC: UIViewController {

    @IBOutlet weak var totalProductLbl: Label!
    @IBOutlet weak var tblView: UITableView!
    
    var page = 1
    var arrProduct = [ProductModel]()
    var refreshControl = UIRefreshControl.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tblView.refreshControl = refreshControl
    }
    
    func setupDetails() {
        if arrProduct.count == 0 {
            page = 1
            serviceCallToGetProductList()
        }
    }
    
    @objc func refreshData() {
        refreshControl.endRefreshing()
        page = 1
        serviceCallToGetProductList()
    }
    
    @IBAction func clickToFilter(_ sender: Any) {
        
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
extension ProductTabVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "ProductListTVC", bundle: nil), forCellReuseIdentifier: "ProductListTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProduct.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductListTVC = tblView.dequeueReusableCell(withIdentifier: "ProductListTVC") as! ProductListTVC
        cell.setupDetails(arrProduct[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : ProductDetailVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.productData = arrProduct[indexPath.row]
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductTabVC {
    func serviceCallToGetProductList() {
        ProductAPIManager.shared.serviceCallToGetProductList(page) { (data, last_page) in
            if self.page == 1 {
                self.arrProduct = [ProductModel]()
            }
            for temp in data {
                self.arrProduct.append(ProductModel.init(temp))
            }
            if self.arrProduct.count > 1 {
                self.totalProductLbl.text = "Products " + String(self.arrProduct.count)
            }else{
                self.totalProductLbl.text = "Product " + String(self.arrProduct.count)
            }
            self.tblView.reloadData()
            if last_page == self.page {
                self.page = 0
            }else{
                self.page += 1
            }
        }
    }
}
