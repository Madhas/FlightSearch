//
//  NavigationController.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 13.09.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? .all
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppearance()
    }

    private func configureAppearance() {
        navigationBar.barTintColor = .backgroundNavigation
        navigationBar.tintColor = .white
        navigationBar.shadowImage = UIImage()
    }
}
