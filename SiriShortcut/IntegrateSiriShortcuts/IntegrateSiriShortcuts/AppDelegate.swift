//
//  AppDelegate.swift
//  IntegrateSiriShortcuts
//
//  Created by DerekYuYi on 2019/1/30.
//  Copyright © 2019 Wenlemon. All rights reserved.
//

import UIKit
import ArticleKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var nav: UINavigationController?
    
    let rootVC = ArticleFeedViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        nav = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        // do other things
        ArticleManager.loadArticles()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        ArticleManager.writeArticlesToDisk()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        ArticleManager.loadArticles()
        rootVC.viewWillAppear(false)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // -------------------------------------------- //
    func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        if userActivityType == "com.Summer.IntegrateSiriShortcuts" {
            return true
        }
        return false
    }
    
    // 类似于 Deeplink 的功能, 从用户中心点击进来之后, 在这里处理在 App 里面的去处
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard userActivity.interaction == nil else {
            ArticleManager.loadArticles()
            rootVC.viewWillAppear(false)
            return false
        }
        
        let vc = NewArticleViewController()
        nav?.pushViewController(vc, animated: false)
        return true
    }
    


}

