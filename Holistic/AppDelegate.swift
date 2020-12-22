//
//  AppDelegate.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import IQKeyboardManagerSwift
import MFSideMenu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var activityLoader : NVActivityIndicatorView!
    var customTabbarVc : CustomTabBarController!
    var container : MFSideMenuContainerViewController = MFSideMenuContainerViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //IQKeyboard
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        
        serviceCallToGetCountry()
        
        if isUserLogin() {
            AppModel.shared.currentUser = getLoginUserData()
            navigateToDashBoard()
        }
        return true
    }

    //MARK:- Share Appdelegate
    func storyboard() -> UIStoryboard
    {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func sharedDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //MARK:- Tab bar
    func showTabBar() {
        if customTabbarVc != nil {
            customTabbarVc.setTabBarHidden(tabBarHidden: false)
        }
    }
    
    func hideTabBar() {
        if customTabbarVc != nil {
            customTabbarVc.setTabBarHidden(tabBarHidden: true)
        }
    }
    
    //MARK:- Navigation
    func navigateToDashBoard() {
        let rootVC: MFSideMenuContainerViewController = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "MFSideMenuContainerViewController") as! MFSideMenuContainerViewController
        container = rootVC
        
        customTabbarVc = (STORYBOARD.MAIN.instantiateViewController(withIdentifier: "CustomTabBarController") as! CustomTabBarController)
        if #available(iOS 9.0, *) {
            let leftSideMenuVC: UIViewController = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "SideMenuVC")
            container.menuWidth = 290
            container.panMode = MFSideMenuPanModeSideMenu
            container.menuSlideAnimationEnabled = true
            container.leftMenuViewController = leftSideMenuVC
            container.centerViewController = customTabbarVc
            
            container.view.layer.masksToBounds = false
            container.view.layer.shadowOffset = CGSize(width: 10, height: 10)
            container.view.layer.shadowOpacity = 0.5
            container.view.layer.shadowRadius = 5
            container.view.layer.shadowColor = UIColor.clear.cgColor
            let rootNavigatioVC : UINavigationController = self.window?.rootViewController
                as! UINavigationController
            rootNavigatioVC.pushViewController(container, animated: false)
        }
    }
    
    func logoutFromApp() {
        removeUserDefaultValues()
        let navigationVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "EmailLoginVCNav") as! UINavigationController
        self.window?.rootViewController = navigationVC
    }
    
    func shareBlog(_ dict : BlogModel) {
        var arrShare = [Any]()
        let text = "Holistic\n" + dict.title
        arrShare.append(text)
        
        if let imgUrl = NSURL(string:dict.get_single_media.url) {
            arrShare.append(imgUrl)
        }
        let activityViewController = UIActivityViewController(activityItems: arrShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = UIApplication.topViewController()?.view
        UIApplication.topViewController()!.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK:- AppDelegate Method
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//MARK:- Loader
extension AppDelegate {
    func showLoader()
    {
        removeLoader()
        window?.isUserInteractionEnabled = false
        activityLoader = NVActivityIndicatorView(frame: CGRect(x: ((window?.frame.size.width)!-50)/2, y: ((window?.frame.size.height)!-50)/2, width: 50, height: 50))
        activityLoader.type = .ballSpinFadeLoader
        activityLoader.color = OrangeColor
        window?.addSubview(activityLoader)
        activityLoader.startAnimating()
    }
    
    func removeLoader()
    {
        window?.isUserInteractionEnabled = true
        if activityLoader == nil {
            return
        }
        activityLoader.stopAnimating()
        activityLoader.removeFromSuperview()
        activityLoader = nil
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

extension AppDelegate {
    func serviceCallToGetCountry() {
        if getCountryData().count == 0 {
            LoginAPIManager.shared.serviceCallToGetCountry { (data) in
                var arrCountry = [CountryModel]()
                for temp in data {
                    arrCountry.append(CountryModel.init(temp))
                }
                setCountryData(arrCountry)
            }
        }
    }
    
    func serviceCallToGetMyCart() {
        ProductAPIManager.shared.serviceCallToGetMyCart(false) { (data) in
            AppModel.shared.MY_CART = [CartModel]()
            for temp in data {
                AppModel.shared.MY_CART.append(CartModel.init(temp))
            }
        }
    }
}
