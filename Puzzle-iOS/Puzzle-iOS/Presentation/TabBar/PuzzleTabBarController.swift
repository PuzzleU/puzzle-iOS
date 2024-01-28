//
//  PuzzleTabBarController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 1/27/24.
//

import UIKit

import Then

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
        tabBar.do {
            $0.backgroundColor = .white
            $0.unselectedItemTintColor = .blue
            $0.tintColor = .gray
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
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
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.title = title
        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        navigation.navigationBar.isHidden = true
        return navigation
    }
}
