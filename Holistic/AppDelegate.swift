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
import UserNotifications
import Firebase
import FirebaseMessaging
import FirebaseInstanceID

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var activityLoader : NVActivityIndicatorView!
    var customTabbarVc : CustomTabBarController!
    var container : MFSideMenuContainerViewController = MFSideMenuContainerViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window?.backgroundColor = UIColor.white
        //IQKeyboard
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        
        //Firebase
        FirebaseApp.configure()
        
        //Push Notification
        registerPushNotification(application)
        Messaging.messaging().delegate = self
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        serviceCallToGetCountry()
        
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
        let arrCountry = getCountryData()
        let info = isInfoScreenDisplayed()
        let tool = isToolTipDisplayed()
        let hotel = isFirstHotelPopup()
        let restaurant = isFirstRestaurantPopup()
        removeUserDefaultValues()
        setCountryData(arrCountry)
        setInfoScreenDisplayed(info)
        setToolTipDisplayed(tool)
        setFirstHotelPopup(hotel)
        setFirstRestaurantPopup(restaurant)
        
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
    
    //MARK:- Notification
    func registerPushNotification(_ application: UIApplication)
    {
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
    }
    
    func getFCMToken() -> String
    {
        return Messaging.messaging().fcmToken ?? ""
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        printData("Notification registered")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        printData("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    //Get Push Notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        //application.applicationIconBadgeNumber = Int((userInfo["aps"] as! [String : Any])["badge"] as! String)!
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        printData(userInfo)
        // handler for Push Notifications
        completionHandler(UIBackgroundFetchResult.newData)
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

extension AppDelegate {
    func serviceCallToGetUserDetail() {
        ProfileAPIManager.shared.serviceCallToGetUserDetail {
            NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.UPDATE_CURRENT_USER_DATA), object: nil)
        }
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
            AppModel.shared.MY_CART_COUNT = data.count
            NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.UPDATE_CART_COUNT), object: nil)
        }
    }
}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if getPushToken() == "" && fcmToken != nil
        {
            setPushToken(fcmToken!)
        }
    }
}

// MARK:- Push Notification
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        _ = notification.request.content.userInfo
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if UIApplication.shared.applicationState == .inactive
        {
            _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(delayForNotification(tempTimer:)), userInfo: userInfo, repeats: false)
        }
        else
        {
            notificationHandler(userInfo as! [String : Any])
        }
        
        completionHandler()
    }
    
    @objc func delayForNotification(tempTimer:Timer)
    {
        notificationHandler(tempTimer.userInfo as! [String : Any])
    }
    
    //Redirect to screen
    func notificationHandler(_ dict : [String : Any])
    {
        if !isUserLogin(){
            return
        }
        printData(dict)
        NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDIRECT_NOTIFICATION_SCREEN), object: nil)
        /*["google.c.sender.id": 285986607267, "gcm.notification.action_destination": , "gcm.notification.action": , "fcm_options": {
            image = "";
        }, "google.c.a.e": 1, "gcm.message_id": 1612447455975304, "aps": {
            alert =     {
                body = "You have successfully made your purchase and achieved loyalty points against it. Check your loyalty points section to see options of redemption.";
                title = "Product Purchase";
            };
            "mutable-content" = 1;
        }]*/
    }
}
