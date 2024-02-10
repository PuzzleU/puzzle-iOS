//
//  UIViewController+.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/7/24.
//

import UIKit

import SnapKit
import Then

extension UIViewController {
    
    func pushToViewController() {
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    func showToast(message: String) {
        Toast.show(message: message, view: self.view, safeAreaBottomInset: self.safeAreaBottomInset())
    }
    
    func safeAreaBottomInset() -> CGFloat {
        return view.safeAreaInsets.bottom
    }
}

public class Toast {
    public static func show(message: String, view: UIView, safeAreaBottomInset: CGFloat = 0) {
        
        let toastContainer = UIView().then {
            $0.backgroundColor = .gray.withAlphaComponent(0.7)
            $0.alpha = 1.0
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
            $0.isUserInteractionEnabled = false
        }
        let toastLabel = UILabel().then {
            $0.text = message
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 14)
            $0.textAlignment = .center
            $0.clipsToBounds = true
            $0.numberOfLines = 0
            $0.sizeToFit()
        }
        
        let toastConatinerWidth = toastLabel.intrinsicContentSize.width + 40.0
        
        view.addSubview(toastContainer)
        toastContainer.addSubview(toastLabel)
        
        toastContainer.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(safeAreaBottomInset+233)
            $0.width.equalTo(toastConatinerWidth)
            $0.height.equalTo(36)
        }
        
        toastLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, delay: 2.0, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
