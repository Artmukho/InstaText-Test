//
//  AppDelegate.swift
//  TestTask
//
//  Created by Artem Muho on 21.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ModuleAssembler.modelAssembly()
        window?.makeKeyAndVisible()
        
        return true
    }

}

