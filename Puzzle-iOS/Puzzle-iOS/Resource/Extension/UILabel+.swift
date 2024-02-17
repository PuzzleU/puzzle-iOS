//
//  UILabel+.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import Foundation
import UIKit

extension UILabel {
    
    /// 특정 문자열의 일부 범위를 다른 폰트, 컬러로 적용시킬때 사용하는 함수 입니다.
    func highlightSpecialText(
        mainText: String,
        specialTexts: [String],
        mainAttributes: [NSAttributedString.Key: Any],
        specialAttributes: [NSAttributedString.Key: Any]
    ) {
        let attributedString = NSMutableAttributedString(string: mainText, attributes: mainAttributes)
        
        // 각 특정 문자열에 대해 스타일 적용
        for specialText in specialTexts {
            let specialRange = (mainText as NSString).range(of: specialText)
            
            // 특정 범위가 유효한 경우에만 스타일 적용
            if specialRange.location != NSNotFound {
                attributedString.addAttributes(specialAttributes, range: specialRange)
            }
        }
        
        self.attributedText = attributedString
    }
}

