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
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .blue
        tabBar.tintColor = .gray
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        //        tabBar.layer.applyShadow(alpha: 0.03, y: -4, blur: 5)
    }
    
    private func setTabBarControllers() {
        let tabBar = [
            ("홈", "home", "home_fill", ViewController()),
            ("검색", "search", "search_fill", ViewController()),
            ("등록", "register", "register_fill", ViewController()),
            ("지원 현황", "applicationStatus", "applicationStatus_fill", ViewController()),
            ("My", "myPage", "my_fill", ViewController())
        ]
        
        viewControllers = tabBar.map { title, unselected, selected, viewController in
            let unselectedImage = UIImage(named: unselected) ?? UIImage()
            let selectedImage = UIImage(named: selected) ?? UIImage()
            return templateNavigationController(title: title, unselectedImage: unselectedImage, selectedImage: selectedImage, rootViewController: viewController)
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
