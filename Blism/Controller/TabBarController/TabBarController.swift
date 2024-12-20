//
//  TabBarController.swift
//  Blism
//
//  Created by 이수현 on 12/20/24.
//

import UIKit

class TabBarController: UITabBarController {
    private let searchVC = UINavigationController(rootViewController: SearchNicknameViewController())
    private let homeVC = UINavigationController(rootViewController:HomeViewController())
    private let myPageVC = UINavigationController(rootViewController:MyPageViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#EDEFF4")
        self.tabBar.tintColor = UIColor(hex: "#314B9E")
        self.tabBar.isTranslucent = false
        
        searchVC.tabBarItem = UITabBarItem(title: nil, image: .tabZoom, tag: 0)
        homeVC.tabBarItem = UITabBarItem(title: nil, image: .tabHome, tag: 1)
        myPageVC.tabBarItem = UITabBarItem(title: nil, image: .tabUser, tag: 2)

        self.viewControllers = [searchVC, homeVC, myPageVC]
        self.selectedIndex = 1
    }
}
