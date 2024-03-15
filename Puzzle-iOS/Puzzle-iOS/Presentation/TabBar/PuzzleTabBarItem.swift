//
//  PuzzleTabBarItem.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 1/29/24.
//

import UIKit

enum PuzzleTabBarItem {
    case home
    case search
    case register
    case applicationStatus
    case myPage
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .search:
            return "검색"
        case .register:
            return "등록"
        case .applicationStatus:
            return "지원 현황"
        case .myPage:
            return "My"
        }
    }
    
    var unselectedImage: UIImage {
        switch self {
        case .home:
            return UIImage(named: "home") ?? UIImage()
        case .search:
            return UIImage(named: "search") ?? UIImage()
        case .register:
            return UIImage(named: "register") ?? UIImage()
        case .applicationStatus:
            return UIImage(named: "applicationStatus") ?? UIImage()
        case .myPage:
            return UIImage(named: "myPage") ?? UIImage()
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .home:
            return UIImage(named: "home_fill") ?? UIImage()
        case .search:
            return UIImage(named: "search_fill") ?? UIImage()
        case .register:
            return UIImage(named: "register_fill") ?? UIImage()
        case .applicationStatus:
            return UIImage(named: "applicationStatus_fill") ?? UIImage()
        case .myPage:
            return UIImage(named: "myPage_fill") ?? UIImage()
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .home, .search, .register, .applicationStatus, .myPage:
            return ViewController(repository: DefaultSplashRepository(splashService: DefaultSplashService())) // 각 탭의 뷰컨 추가 되면 case 마다 변경
        }
    }
}
