//
//  PuzzleTabBarController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 1/27/24.
//

import UIKit

class PuzzleTabBarController: UITabBarController {
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let tabBar = [
            ("홈", "home", ViewController()),
            ("검색", "search", ViewController()),
            ("등록", "register", ViewController()),
            ("지원 현황", "applicationStatus", ViewController()),
            ("My", "myPage", ViewController())
        ]
        
        viewControllers = tabBar.map { title, imageName, viewController in
            let image = UIImage(named: imageName) ?? UIImage()
            return templateNavigationController(title: title, unselectedImage: image, selectedImage: image, rootViewController: viewController)
        }
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
