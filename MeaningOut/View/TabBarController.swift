//
//  TabBarController.swift
//  MeaningOut
//
//  Created by 심소영 on 6/14/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = TextResource.ColorRGB.orangeUI
        tabBar.unselectedItemTintColor = TextResource.ColorRGB.grayUI
        
        let search = MainViewController()
        let nav1 = UINavigationController(rootViewController: search)
        nav1.tabBarItem = UITabBarItem(title: TextResource.ButtonText.tabBarSearch.rawValue, image: UIImage(systemName: TextResource.SystemImageName.magnifyingglass.rawValue), tag: 0)
        let setting = SettingViewController()
        let nav2 = UINavigationController(rootViewController: setting)
        nav2.tabBarItem = UITabBarItem(title: TextResource.ButtonText.tabBarSetting.rawValue, image: UIImage(systemName: TextResource.SystemImageName.person.rawValue), tag: 1)
        setViewControllers([nav1, nav2], animated: true)
        
    }

}
