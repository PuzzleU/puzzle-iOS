//
//  PuzzleTabBarController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 1/27/24.
//

import UIKit

import Then

class PuzzleTabBarController: UITabBarController {
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTabBarControllers()
    }
}

//MARK: - Methods

extension PuzzleTabBarController {
    private func setUI() {
        tabBar.do {
            $0.backgroundColor = .puzzleWhite
            $0.unselectedItemTintColor = .puzzleBlack
            $0.tintColor = .puzzleGray400
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    private func setTabBarControllers() {
        let tabBarItems: [PuzzleTabBarItem] = [
            .home,
            .search,
            .register,
            .applicationStatus,
            .myPage
        ]
        
        viewControllers = tabBarItems.map { item in
            return templateNavigationController(
                title: item.title,
                unselectedImage: item.unselectedImage,
                selectedImage: item.selectedImage,
                rootViewController: item.viewController
            )
        }
    }
    
    private func templateNavigationController(title: String, unselectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: rootViewController).then {
            $0.title = title
            $0.tabBarItem.image = unselectedImage
            $0.tabBarItem.selectedImage = selectedImage
            $0.navigationBar.isHidden = true
        }
    }
}
