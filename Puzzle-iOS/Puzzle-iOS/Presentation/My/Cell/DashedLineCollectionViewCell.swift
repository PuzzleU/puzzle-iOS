//
//  DashedLineCollectionViewCell.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/10/24.
//

import UIKit
import SnapKit
import Then

class DashedLineCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel = LabelFactory.build(
        text: "타이틀",
        font: .body1
    )
    
    private let contentLabel = UILabel().then {
        $0.font = .body2
        $0.textColor = .puzzleGray300
        $0.textAlignment = .center
    }
    
    private let dashedView = DashedBorderView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        addSubviews(titleLabel, dashedView)
        dashedView.addSubview(contentLabel)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(14)
        }
        
        dashedView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(52)
        }
        
        contentLabel.snp.makeConstraints {
            $0.centerX.equalTo(dashedView.snp.centerX)
            $0.centerY.equalTo(dashedView.snp.centerY)
        }
    }
    
    func configure(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
}

class DashedBorderView: UIView {
    private var dashBorder: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 기존에 추가된 CAShapeLayer 제거
        dashBorder?.removeFromSuperlayer()
        
        let dashPattern: [CGFloat] = [3, 3]
        let shapeLayer = CAShapeLayer().then {
            $0.lineWidth = 2
            $0.strokeColor = UIColor.puzzleGray300.cgColor
            $0.lineDashPattern = dashPattern as [NSNumber]
            $0.fillColor = nil
            $0.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 16).cgPath
        }
        
        self.layer.addSublayer(shapeLayer)
        self.dashBorder = shapeLayer
    }
}

extension UIView {
    func addDashedBorder() {
        let color = UIColor.red.cgColor
        
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6, 3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}
