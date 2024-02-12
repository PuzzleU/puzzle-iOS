//
//  FontLiterals.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/10/24.
//

import UIKit

extension UIFont {
    /// pretendardBold 30
    @nonobjc class var largeTitle1: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 30)
    }
    
    /// pretendardBold 20
    @nonobjc class var largeTitle2: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 20)
    }
    
    /// pretendardBold 18
    @nonobjc class var pageTitle: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 18)
    }
    
    /// pretendardMedium 10
    @nonobjc class var pageSubTitle: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 10)
    }
    
    /// pretendardMedium 14
    @nonobjc class var itemTitle: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 14)
    }
    
    /// pretendardMedium 12
    @nonobjc class var itemSubTitle1: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 12)
    }
    
    /// pretendardMedium 10
    @nonobjc class var itemSubTitle2: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 10)
    }
    
    /// pretendardMedium 8
    @nonobjc class var itemSubTitle3: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 8)
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
    
    /// pretendardBold 14
    @nonobjc class var button1: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 14)
    }
    
    /// pretendardMedium 14
    @nonobjc class var button2: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 14)
    }
    
    /// pretendardBold 12
    @nonobjc class var button3: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 12)
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
