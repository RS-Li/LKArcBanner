//
//  AppDelegate.swift
//  LKArcBannerDemo
//
//  Created by 李棒棒 on 2024/6/5.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let bannerVc:ArcBannerVc = ArcBannerVc()
        let nav = UINavigationController(rootViewController: bannerVc)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }

    
    //应用程序将退出活动
    func applicationWillResignActive(_ application: UIApplication) {
       
        
    }
    
    //应用程序已经进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        
    }
    
    //应用将进入前台
    func applicationWillEnterForeground(_ application: UIApplication) {
        ///开启全屏广告
        // RootVcManager.manager.openScreenAdView()
        
    }
    
    //应用已经进入前台活跃了
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    //应用将关闭
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    
    /*
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
*/

}

