//
//  UIView+.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/9/24.
//

import UIKit

extension UIView {
    
    /// UIView 여러 개 인자로 받아서 한 번에 addSubview 합니다.
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
    
    /// 테두리 점선 으로 만들어 주는 메서드
    func addDashedBorder(
        strokeColor: UIColor,
        lineWidth: CGFloat,
        dashPattern: [NSNumber],
        cornerRadius: CGFloat
    ) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.fillColor = nil
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        
        layer.addSublayer(shapeLayer)
    }
}
