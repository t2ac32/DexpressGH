//
//  AppDelegate.swift
//  DexpressGH
//
//  Created by Tracer on 27/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MainModuleBuilder.build())
        window?.makeKeyAndVisible()
        return true
    }
}
