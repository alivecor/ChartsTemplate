//
//  AppDelegate.swift
//  ChartsTemplate
//
//  Created by Rex Hsu on 1/30/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = DemoListViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            nav.navigationBar.standardAppearance = appearance
            nav.navigationBar.scrollEdgeAppearance = appearance
        }
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }


}

