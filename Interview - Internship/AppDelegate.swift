//
//  AppDelegate.swift
//  Interview - Internship
//
//  Created by Alessio Sardella on 05/03/2019.
//  Copyright © 2019 Lepaya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let viewController = TrainerListViewController()
        let navigation = UINavigationController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigation
        navigation.pushViewController(viewController, animated: true)
        window?.makeKeyAndVisible()
        return true
    }
}

