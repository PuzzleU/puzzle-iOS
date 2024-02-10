//
//  UIViewController+.swift
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
    
    
    
    
    
    
    
    
    
    
    func showToast(message: String, heightOffset: CGFloat? = nil) {
        let height = heightOffset ?? 233 // default 값

        Toast.show(
            message: message,
            view: self.view,
            safeAreaBottomInset: self.safeAreaBottomInset(),
            height: height
        )
    }
    
    private func safeAreaBottomInset() -> CGFloat {
        return view.safeAreaInsets.bottom
    }
}
