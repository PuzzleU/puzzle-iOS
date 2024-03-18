//
//  addShadow.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/5/24.
//

import UIKit

/**
 
 - Description:
 
 View의 Layer 계층(CALayer)에 shadow를 간편하게 입힐 수 있는 메서드입니다.
 
 */

public extension CALayer {
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0) {
            
            masksToBounds = false
            shadowColor = color.cgColor
            shadowOpacity = alpha
            shadowOffset = CGSize(width: x, height: y)
            shadowRadius = blur / 2.0
            if spread == 0 {
                shadowPath = nil
            } else {
                let dx = -spread
                let rect = bounds.insetBy(dx: dx, dy: dx)
                shadowPath = UIBezierPath(rect: rect).cgPath
            }
        }
}
