//
//  AppDelegate.swift
//  Soareasy
//
//  Created by Cynthia D'Phoenix on 7/22/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            window = UIWindow(frame: UIScreen.main.bounds)
            let onboardingVC = OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            let dashboard = DashboardViewController()
            window?.rootViewController = dashboard
            window?.makeKeyAndVisible()
            
            return true
        }


}

