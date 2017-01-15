//
//  AppDelegate.swift
//  NewNotifications (Udemy)
//
//  Created by Mahmoud Hamad on 1/2/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().delegate = self
        configureUserNotifications()
        
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

    //new   (presenting the notification)
    private func configureUserNotifications() {
        
        //create our actions in notification
        let favAction = UNNotificationAction(identifier: "fistBump", title: "👊 Fist Bump" , options: [])
        let dismissAction = UNNotificationAction(identifier: "dismiss", title: "Dismiss" , options: [])
        
        //set category. connected with extension info.plist
        let category = UNNotificationCategory(identifier: "myNotificationCategory", actions: [favAction, dismissAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        //we got this func set up.. now we need to call it
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler(.alert)
    }
    
    //do the processing with those actions
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void ) {
        
        print("Response Receive for \(response.actionIdentifier)")
        completionHandler()
        //we will just get what they tapped on dissmissAction or favAction
        
        //and this right here is where you would if you wanted to do some kind of like if its a favorite action and you could incromant a favorite counter or something like that. that's where you do this
    }
    
    
}

