//
//  AppDelegate.swift
//  OrangeHACKATHON
//
//  Created by bakebrlk on 13.09.2023.
//

import UIKit
import FirebaseCore
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        if(!StorageUserDefaultModal.checkOnbording){
            StorageUserDefaultModal.checkOnbording = true
            let hosting = UIHostingController(rootView: OnBordingView())
            window?.rootViewController = UINavigationController(rootViewController: hosting)
            
        }else if(!StorageUserDefaultModal.checkLogin){
            StorageUserDefaultModal.checkOnbording = true
            window?.rootViewController = UINavigationController(rootViewController: ViewController())
        }else{
            let hosting = UIHostingController(rootView: ProfileView())
            window?.rootViewController = UINavigationController(rootViewController: hosting)
            
        }

        FirebaseApp.configure()
        
        return true
    }


}

