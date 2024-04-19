//
//  PuzzleInfoView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/19/24.
//

import UIKit

import SnapKit
import Then

struct PuzzleCustomView {
    /// image 유무에 따라 레이아웃이 변경 되는 함수 입니다.
    static func makeInfoView(title: String, image: UIImage? = nil) -> UIView {
        let containerView = UIView()
        
        let underLineView = UIView().then {
            $0.backgroundColor = .puzzleGray300
        }
        
        let label = UILabel().then {
            $0.text = title
            $0.textColor = .puzzleBlack
            $0.font = .body2
        }
        
        let icArrowRight = UIImageView().then {
            $0.image = UIImage(resource: .icRightArrow)
        }
        
        containerView.addSubviews(icArrowRight, underLineView)
        
        icArrowRight.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }
        
        // 이미지 유무에 따라 레이아웃 다르게
        if let validImage = image {
            let imageView = UIImageView(image: validImage)
            containerView.addSubviews(imageView, label)
            
            imageView.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.centerY.equalToSuperview()
            }
            
            label.snp.makeConstraints {
                $0.leading.equalTo(imageView.snp.trailing).offset(8)
                $0.centerY.equalToSuperview()
            }
        } else {
            containerView.addSubviews(label)
            
            label.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.centerY.equalToSuperview()
            }
        }
        
        return containerView
        
    }
}
