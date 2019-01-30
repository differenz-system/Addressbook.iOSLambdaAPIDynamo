//
//  AppDelegate.swift
//  AddressBook
//
//  Created by MohiniPatel on 9/20/17.
//  Copyright © 2017 Differenz System. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var frontNavigationController: UINavigationController?
    var vc : UIViewController?
    var header:String?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Setup RootViewController
        self.setupRootView()
        
        IQKeyboardManager.sharedManager().enable = true

        return true
    }
    
    
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
    
    // MARK: - Instance Method
    
    //MARK: - API call method
    /**
     This method is setup root view controller of app.
     */
    func setupRootView() {
        //Check user is already login or not
        let isLogin = UserDefaults.standard.bool(forKey: Constant.UserDefaultsKey.IsLogin)
        
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        if (isLogin) {
            //Show Address list screen in case of auto login
            vc = storyboard.instantiateViewController(withIdentifier: Constant.VCIdetinfier.AddressListVC) as! AddressListVC
        }
        else {
            //Show login screen if user is not login
            vc = storyboard.instantiateViewController(withIdentifier: Constant.VCIdetinfier.LoginVC) as! LoginVC
        }
        frontNavigationController = UINavigationController(rootViewController: vc!)
        frontNavigationController?.navigationBar.barTintColor = UIColor.navigationBarBGColor
        frontNavigationController?.navigationBar.setDafaultAppNavigationTitleAttributes()
        window?.rootViewController = frontNavigationController
    }
    
    // MARK: - SVProgressHUD configuration Method
    
    /**
     This method is setup SVProgressHUD default config.
     */
    func setSVProgressHUDconfiguration() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.custom)
        SVProgressHUD.setBackgroundLayerColor(UIColor.black.withAlphaComponent(0.2))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.black.withAlphaComponent(0.5))
        if Utilities.isDeviceiPad() {
            SVProgressHUD.setMinimumSize(CGSize(width: 150, height: 150))
        }
        else {
            SVProgressHUD.setMinimumSize(CGSize(width: 75, height: 75))
        }
        
    }
}

