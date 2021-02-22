//
//  CustomTabBarView.swift
//  Event Project
//
//  Created by Amisha on 20/07/17.
//  Copyright © 2017 AK Infotech. All rights reserved.
//

import UIKit

protocol CustomTabBarViewDelegate
{
    func tabSelectedAtIndex(index:Int)
}

class CustomTabBarView: UIView {
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    @IBOutlet weak var tabView1: UIView!
    @IBOutlet weak var tabView2: UIView!
    @IBOutlet weak var tabView3: UIView!
    @IBOutlet weak var tabView4: UIView!
    @IBOutlet weak var tabView5: UIView!
    
    var delegate:CustomTabBarViewDelegate?
    var lastIndex : NSInteger!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    convenience init(frame: CGRect, title: String) {
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize()
    {
        lastIndex = 0
    }
    
    @IBAction func tabBtnClicked(_ sender: UIButton)
    {
        let btn: UIButton = sender
        lastIndex = btn.tag - 1
        
        resetAllButton()
        selectTabButton()
        
    }
    
    func resetAllButton()
    {
        btn1.isSelected = false
        btn2.isSelected = false
        btn3.isSelected = false
        btn4.isSelected = false
        btn5.isSelected = false
        
        tabView1.isHidden = true
        tabView2.isHidden = true
        tabView3.isHidden = true
        tabView4.isHidden = true
        tabView5.isHidden = true
    }
    
    func selectTabButton()
    {
        switch lastIndex {
            case 0:
                btn1.isSelected = true
                tabView1.isHidden = false
                break
            case 1:
                btn2.isSelected = true
                tabView2.isHidden = false
                break
            case 2:
                btn3.isSelected = true
                tabView3.isHidden = false
                break
            case 3:
                btn4.isSelected = true
                tabView4.isHidden = false
                break
            case 4:
                btn5.isSelected = true
                tabView5.isHidden = false
                break
            default:
                break
        }
        delegate?.tabSelectedAtIndex(index: lastIndex)
    }
}
