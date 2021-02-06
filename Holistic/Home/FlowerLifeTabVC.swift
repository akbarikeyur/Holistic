//
//  FlowerLifeTabVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class FlowerLifeTabVC: UIViewController {

    @IBOutlet weak var flowerImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupDetails() {
        let height = SCREEN.HEIGHT - 388
        NotificationCenter.default.post(name: NSNotification.Name.init("UPDATE_LIFESTYLE_HEIGHT"), object: height)
    }
    
    
    func setFlower(_ value : Int) {
        if value > 100 {
            flowerImg.image = UIImage(named: "flower_100")
        }
        else if value > 75 {
            flowerImg.image = UIImage(named: "flower_75")
        }
        else if value > 50 {
            flowerImg.image = UIImage(named: "flower_50")
        }
        else if value > 25 {
            flowerImg.image = UIImage(named: "flower_25")
        }
        else {
            flowerImg.image = UIImage(named: "flower_off")
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
