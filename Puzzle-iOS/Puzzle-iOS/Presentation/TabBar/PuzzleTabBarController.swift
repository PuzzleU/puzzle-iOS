//
//  PuzzleTabBarController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 1/27/24.
//

import UIKit

class PuzzleTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setUI()
        setTabBarControllers()
    }
}

// MARK: - Methods

extension PuzzleTabBarController {
    private func setUI() {
        //        tabBar.backgroundColor =
        //        tabBar.unselectedItemTintColor =
        //        tabBar.tintColor =
        //        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        //        tabBar.layer.applyShadow(alpha: 0.03, y: -4, blur: 5)
    }
    
    private func setTabBarControllers() {
        let homeNVC = templateNavigationController(title: "홈",
                                                   unselectedImage: ,
                                                   selectedImage: ,
                                                   rootViewController: ViewController())
        let searchNVC = templateNavigationController(title: "검색",
                                                     unselectedImage: ,
                                                     selectedImage: ,
                                                     rootViewController: ViewController())
        let enrollNVC = templateNavigationController(title: "등록",
                                                     unselectedImage: UIImage(systemName: "plus.circle")!,
                                                     selectedImage: UIImage(systemName: "plus.circle")!,
                                                     rootViewController: ViewController())
        let applicationStatusNVC = templateNavigationController(title: "지원 현황",
                                                                unselectedImage: ,
                                                                selectedImage: ,
                                                                rootViewController: ViewController())
        let myPageNVC = templateNavigationController(title: "My",
                                                     unselectedImage: ,
                                                     selectedImage: ,
                                                     rootViewController: ViewController())
        
        viewControllers = [homeNVC, searchNVC, enrollNVC, applicationStatusNVC, myPageNVC]
    }
    
    private func templateNavigationController(title: String, unselectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.title = title
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.isHidden = true
        return nav
    }
}
