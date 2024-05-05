//
//  ContainerTabBarController.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Osama on 05/05/2024.
//

import UIKit

class ContainerTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBar()
    }
    
    private func setupViewControllers() {
        delegate = self
        let vc = NowPlayingViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.prefersLargeTitles = false
        let viewController1 = nav
        
        let nowPlayingImage = UIImage(systemName: "newspaper.fill")
        viewController1.tabBarItem.image = nowPlayingImage
        viewController1.tabBarItem.title = "Now Playing"
        
        let viewController2 = UINavigationController(rootViewController:  PopularViewController())
        let popularImage = UIImage(systemName: "flame.fill")
        viewController2.tabBarItem.image = popularImage
        viewController2.tabBarItem.title = "Popular"

        let viewController3 = UINavigationController(rootViewController:  UpcommingViewController())
        viewController3.tabBarItem.image = UIImage(systemName: "figure.run.square.stack")
        viewController3.tabBarItem.title = "Upcomming"

        viewControllers = [
            viewController1,
            viewController2,
            viewController3
        ]
    }
    
    private func setupTabBar() {
        tabBar.barTintColor = .black
        tabBar.backgroundColor = .black
        tabBar.tintColor = .systemRed
        tabBar.unselectedItemTintColor = .white
        tabBar.shadowImage = .init()
    }
}

extension ContainerTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
