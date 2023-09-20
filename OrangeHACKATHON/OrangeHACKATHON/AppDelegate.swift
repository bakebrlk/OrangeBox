//
//  AppDelegate.swift
//  OrangeHACKATHON
//
//  Created by bakebrlk on 13.09.2023.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: SignIn())
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        return true
    }


}

