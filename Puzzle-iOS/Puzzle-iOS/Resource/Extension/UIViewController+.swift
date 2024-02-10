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
    
    
    
    
    
    
    
    
    
    
    func showToast(message: String, verticalOffset: CGFloat? = nil) {
        let vertical = verticalOffset ?? 233 // defalut = 233

        Toast.show(
            message: message,
            view: self.view,
            safeAreaBottomInset: self.safeAreaBottomInset(),
            verticalOffset: vertical
        )
    }
    
    private func safeAreaBottomInset() -> CGFloat {
        return view.safeAreaInsets.bottom
    }
}
