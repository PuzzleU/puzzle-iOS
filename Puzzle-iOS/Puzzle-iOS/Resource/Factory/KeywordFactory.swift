//
//  KeywordFactory.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/10/24.
//

import UIKit

import Then

struct KeywordFactory {
    static func build(
        text: String,
        font: UIFont,
        textColor: UIColor = .puzzleWhite,
        backgroundColor: UIColor,
        textAlignment: NSTextAlignment = .center
    ) -> UIView {
        let keywordLabel = UILabel().then {
            $0.text = text
            $0.font = font
            $0.textColor = textColor
            $0.textAlignment = textAlignment
        }
        
        let keywordView = UIView().then {
            $0.backgroundColor = backgroundColor
            $0.layer.cornerRadius = 12
        }
        
        keywordView.addSubview(keywordLabel)
        
        keywordLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10))
        }
        
        return keywordView
    }
}
