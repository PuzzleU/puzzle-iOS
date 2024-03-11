//
//  TypeIconFactory.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/10/24.
//

import UIKit

import Then

struct TypeIconFactory {
    static func build(
        text: String,
        font: UIFont,
        textColor: UIColor,
        textAlignment: NSTextAlignment = .center,
        borderColor: CGColor
    ) -> UIView {
        let keywordLabel = UILabel().then {
            $0.text = text
            $0.font = font
            $0.textColor = textColor
            $0.textAlignment = textAlignment
        }
        
        let keywordView = UIView().then {
            $0.layer.cornerRadius = 2
            $0.layer.borderColor = borderColor
            $0.layer.borderWidth = 1
        }
        
        keywordView.addSubview(keywordLabel)
        
        keywordLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6))
        }
        
        return keywordView
    }
}
