//
//  LabelFactory.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/2/24.
//

import UIKit

import Then

struct LabelFactory {
    static func build(
        text: String?,
        font: UIFont,
        backgroundColor: UIColor = .clear,
        textColor: UIColor = .puzzleBlack,
        textAlignment: NSTextAlignment = .center) -> UILabel {
            return UILabel().then {
                $0.text = text
                $0.font = font
                $0.backgroundColor = backgroundColor
                $0.textColor = textColor
                $0.textAlignment = textAlignment
            }
        }
}
