//
//  MainTabBarViewController.swift
//  ModuleForApp
//
//  Created by 王杰 on 2022/8/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        
        let vc1 = UINavigationController(rootViewController: FirstViewController())
        let vc2 = UINavigationController(rootViewController: SecondViewController())
        let vc3 = UINavigationController(rootViewController: ThirdViewController())
//        let vc4 = UINavigationController(rootViewController: FourthViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
//        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        vc1.title = "Home"
        vc2.title = "Coming Soon"
        vc3.title = "Top Search"
//        vc4.title = "Downloads"
        
        tabBar.tintColor = .label // 蓝色和白色的差别
        viewControllers = [vc1, vc2, vc3]
//        viewControllers = []

    }
}
