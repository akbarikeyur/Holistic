//
//  WelcomeVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var constraintHeightTopView: NSLayoutConstraint!
    
    @IBOutlet weak var infoCV: UICollectionView!
    @IBOutlet weak var myPageControl: UIPageControl!
    
    var unselectValue : CGFloat = 0.8
    var selectValue : CGFloat = 1.2
    var timer : Timer?
    var selectedPage = 0
    var arrWelcome = [WelcomeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        constraintHeightTopView.constant = SCREEN.WIDTH/6
        registerCollectionView()
        clickToSelectTopButton(btn1)
    }
    
    @IBAction func clickToSelectTopButton(_ sender: UIButton) {
        resetButton()
        sender.transform = CGAffineTransform(scaleX: selectValue, y: selectValue)
        
        if sender == btn1 {
            infoCV.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
        }
        else if sender == btn2 {
            infoCV.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: true)
        }
        else if sender == btn3 {
            infoCV.scrollToItem(at: IndexPath(item: 2, section: 0), at: .right, animated: true)
        }
        else if sender == btn4 {
            infoCV.scrollToItem(at: IndexPath(item: 3, section: 0), at: .right, animated: true)
        }
        else if sender == btn5 {
            infoCV.scrollToItem(at: IndexPath(item: 4, section: 0), at: .right, animated: true)
        }
        else if sender == btn6 {
            infoCV.scrollToItem(at: IndexPath(item: 5, section: 0), at: .right, animated: true)
        }
    }
    
    func resetButton() {
        btn1.isSelected = false
        btn2.isSelected = false
        btn3.isSelected = false
        btn4.isSelected = false
        btn5.isSelected = false
        btn6.isSelected = false
        
        btn1.transform = CGAffineTransform(scaleX: unselectValue, y: unselectValue)
        btn2.transform = CGAffineTransform(scaleX: unselectValue, y: unselectValue)
        btn3.transform = CGAffineTransform(scaleX: unselectValue, y: unselectValue)
        btn4.transform = CGAffineTransform(scaleX: unselectValue, y: unselectValue)
        btn5.transform = CGAffineTransform(scaleX: unselectValue, y: unselectValue)
        btn6.transform = CGAffineTransform(scaleX: unselectValue, y: unselectValue)
    }
    
    @IBAction func clickToSkip(_ sender: Any) {
        let vc : EmailLoginVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "EmailLoginVC") as! EmailLoginVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clickToNext(_ sender: Any) {
        selectedPage = myPageControl.currentPage
        if selectedPage == 5 {
            clickToSkip(self)
        }else{
            selectedPage += 1
            redirectToPage()
        }
    }
}

//MARK:- CollectionView Method
extension WelcomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        infoCV.register(UINib.init(nibName: "WelcomeCVC", bundle: nil), forCellWithReuseIdentifier: "WelcomeCVC")
        
        arrWelcome = [WelcomeModel]()
        for temp in getJsonFromFile("welcome") {
            arrWelcome.append(WelcomeModel.init(temp))
        }
        infoCV.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrWelcome.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN.WIDTH, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : WelcomeCVC = infoCV.dequeueReusableCell(withReuseIdentifier: "WelcomeCVC", for: indexPath) as! WelcomeCVC
        cell.setupDetails(arrWelcome[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = infoCV.frame.width - (infoCV.contentInset.left*2)
        let index = infoCV.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.myPageControl.currentPage = Int(roundedIndex)
        
        if timer != nil {
            timer?.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(selectTopButton), userInfo: nil, repeats: false)
        
    }
    
    @objc func selectTopButton() {
        selectedPage = myPageControl.currentPage
        redirectToPage()
    }
    
    func redirectToPage() {
        if selectedPage == 0 {
            clickToSelectTopButton(btn1)
        }
        else if selectedPage == 1 {
            clickToSelectTopButton(btn2)
        }
        else if selectedPage == 2 {
            clickToSelectTopButton(btn3)
        }
        else if selectedPage == 3 {
            clickToSelectTopButton(btn4)
        }
        else if selectedPage == 4 {
            clickToSelectTopButton(btn5)
        }
        else if selectedPage == 5 {
            clickToSelectTopButton(btn6)
        }
    }
}
