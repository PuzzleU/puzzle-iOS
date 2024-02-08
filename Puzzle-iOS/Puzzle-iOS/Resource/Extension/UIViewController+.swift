//
//  File.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/7/24.
//

import UIKit

extension UIViewController {
 
    func pushToViewController() {
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
