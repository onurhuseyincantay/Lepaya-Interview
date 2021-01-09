//
//  AppDelegate.swift
//  Interview - Internship
//
//  Created by Alessio Sardella on 05/03/2019.
//  Copyright © 2019 Lepaya. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    setupWindow()
    return true
  }
}

// MARK: - Private
private extension AppDelegate {
  func setupWindow() {
    let trainerListViewController = TrainerListViewController(view: TrainerListView(),
                                                              viewModel: TrainerListViewModel())
    let navigationController = UINavigationController(rootViewController: trainerListViewController)
    self.window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
}
