//
//  AppDelegate.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 18/05/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(hex: "E9C545")]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().tintColor = UIColor(hex: "E9C545")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataHelper.sharedInstance.saveContext()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataHelper.sharedInstance.saveContext()
    }
}
