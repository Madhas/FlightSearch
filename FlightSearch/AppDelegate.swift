//
//  AppDelegate.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 30.08.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import UIKit
import HTTPWrapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let client = HTTPClient(configuration: .default)
        let controller = FlightSearchModule.assemble(with: client)
        
        let window = UIWindow()
        window.rootViewController = NavigationController(rootViewController: controller)
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }

}

