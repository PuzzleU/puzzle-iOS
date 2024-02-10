//
//  FontLiterals.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/10/24.
//

import UIKit

extension UIFont {
    /// pretendardBold 20
    @nonobjc class var h1: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 20)
    }
    
    /// pretendardBold 18
    @nonobjc class var h2: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 18)
    }
    
    /// pretendardSemiBold 18
    @nonobjc class var h3: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 18)
    }
    
    ///pretendardExtraBold 30
    @nonobjc class var h4: UIFont {
        return UIFont.font(.pretendardExtraBold, ofSize: 30)
    }
}

extension UIFont {
    /// pretendardMedium 17
    @nonobjc class var b1: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 17)
    }
    
    /// pretendardMedium 15
    @nonobjc class var b2: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 15)
    }
    
    /// pretendardRegular 15
    @nonobjc class var b3: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 15)
    }
    
    /// pretendardMedium 14
    @nonobjc class var b4: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 14)
    }
    
    /// pretendardSemiBold 13
    @nonobjc class var b5: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 13)
    }
    
    /// pretendardRegular 13
    @nonobjc class var b6: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 13)
    }
    
    /// pretendardMedium 12
    @nonobjc class var b7: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 12)
    }
    
    /// pretendardRegular 12
    @nonobjc class var b8: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 12)
    }
    
    /// pretendardSemiBold 11
    @nonobjc class var b9: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 11)
    }
}

enum FontName: String {
    case pretendardBold = "Pretendard-Bold"
    case pretendardSemiBold = "Pretendard-SemiBold"
    case pretendardMedium = "Pretendard-Medium"
    case pretendardRegular = "Pretendard-Regular"
    case pretendardExtraBold = "Pretendard-ExtraBold"
}

extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: style.rawValue, size: size) else {
            print("Failed to load the \(style.rawValue) font. Return system font instead.")
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
}
