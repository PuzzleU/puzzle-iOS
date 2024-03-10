//
//  FontLiterals.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/10/24.
//

import UIKit

extension UIFont {
    /// pretendardBold 30
    @nonobjc class var title1: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 30)
    }
    
    /// pretendardBold 20
    @nonobjc class var title2: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 20)
    }
    
    /// pretendardBold 18
    @nonobjc class var subTitle1: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 18)
    }
    
    /// pretendardBold 16
    @nonobjc class var subTitle2: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 16)
    }
    
    /// pretendardBold 14
    @nonobjc class var body1: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 14)
    }
    
    /// pretendardMedium 14
    @nonobjc class var body2: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 14)
    }
    
    /// pretendardRegular 14
    @nonobjc class var body3: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 14)
    }
    
    /// pretendardLight 14
    @nonobjc class var body4: UIFont {
        return UIFont.font(.pretendardLight, ofSize: 14)
    }
    
    /// pretendardBold 12
    @nonobjc class var subTitle3: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 12)
    }
    
    /// pretendardMedium 12
    @nonobjc class var subTitle4: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 12)
    }
    
    /// pretendardMedium 10
    @nonobjc class var caption1: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 10)
    }
    
    /// pretendardMedium 8
    @nonobjc class var caption2: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 8)
    }
    
    /// pretendardBold 10
    @nonobjc class var chip1: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 10)
    }
    
}

enum FontName: String {
    case pretendardBold = "Pretendard-Bold"
    case pretendardMedium = "Pretendard-Medium"
    case pretendardRegular = "Pretendard-Regular"
    case pretendardLight = "Pretendard-Light"
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
