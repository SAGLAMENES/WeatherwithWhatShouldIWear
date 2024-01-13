//
//  TabViewController.swift
//  brightsky
//
//  Created by Afraz Siddiqui on 9/18/23.
//

import UIKit
import SwiftUI

final class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tab1 = WeatherViewController()
        tab1.title = "Weather"
        
        let whatToWearView = WhatToWearView()
                let tab2 = UIHostingController(rootView: whatToWearView)
                tab2.title = "What To Wear"
        
        let tab3 = SettingsViewController()
        tab3.title = "Settings"

        let nav1 = UINavigationController(rootViewController: tab1)
        let nav2 = UINavigationController(rootViewController: tab2)
        

        nav1.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "cloud.sun"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "What To Wear", image: UIImage(systemName: "hanger"), tag: 2)
       

        setViewControllers([
            nav1, nav2,
        ], animated: true)
    }

}
