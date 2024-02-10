//
//  Toast.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/10/24.
//
import UIKit

import SnapKit
import Then

public class PuzzleToastView {
    
    /// 토스트 메시지를 띄우는 함수입니다.
    /// verticalOffset 의 상수를 변경하여 원하는 위치로 높이를 지정 할 수 있습니다.
    /// default = 233
    static func show(
        message: String,
        view: UIView,
        safeAreaBottomInset: CGFloat = 0,
        height: CGFloat = 233
    ) {
        
        // MARK: - UI Components
        
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
        
        //MARK: - UI & Layout
        
        let toastConatinerWidth = toastLabel.intrinsicContentSize.width + 40.0
        
        view.addSubview(toastContainer)
        toastContainer.addSubview(toastLabel)
        
        toastContainer.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(safeAreaBottomInset + height)
            $0.width.equalTo(toastConatinerWidth)
            $0.height.equalTo(36)
        }
        
        toastLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        //MARK: - Animation
        
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

