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
            return UIImage(resource: .icHome)
        case .search:
            return UIImage(resource: .icSearch)
        case .register:
            return UIImage(resource: .icRegister)
        case .applicationStatus:
            return UIImage(resource: .icApplicationStatus)
        case .myPage:
            return UIImage(resource: .icMyPage)
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .home:
            return UIImage(resource: .icHomeFill)
        case .search:
            return UIImage(resource: .icSearchFill)
        case .register:
            return UIImage(resource: .icRegisterFill)
        case .applicationStatus:
            return UIImage(resource: .icApplicationStatusFill)
        case .myPage:
            return UIImage(resource: .icMyPageFill)
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .home:
            return HomeViewController()
        case .myPage:
            return MyProfileViewController()
        case .search, .register, .applicationStatus:
            return ViewController() // 각 탭의 뷰컨 추가 되면 case 마다 변경
        }
    }
}
