//
//  AppDelegate.swift
//  MVC
//
//  Created by Kelvin Tan on 02/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let homeView = HomeRouter.createModule()

        let navigationController = UINavigationController(rootViewController: homeView)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}

