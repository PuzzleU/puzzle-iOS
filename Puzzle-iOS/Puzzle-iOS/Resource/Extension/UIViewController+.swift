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
    
    /// 뷰 컨트롤러가 네비게이션 스택에 있으면 pop 하고, 나머지는  dismiss 합니다.
    func popOrDismissViewController(animated: Bool = true) {
        if let navigationController = self.navigationController, navigationController.viewControllers.contains(self) {
            navigationController.popViewController(animated: animated)
        } else if self.presentingViewController != nil {
            self.dismiss(animated: animated)
        }
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
