//
//  CGFloat+.swift
//  Puzzle
//
//  Created by 신지원 on 2023/10/12.
//

import UIKit

extension CGFloat {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        let ratioH: CGFloat = UIScreen.main.bounds.height / 812
        return ratio <= ratioH ? self * ratio : self * ratioH
    }
}

extension Int {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        let ratioH: CGFloat = UIScreen.main.bounds.height / 812
        return ratio <= ratioH ? CGFloat(self) * ratio : CGFloat(self) * ratioH
    }
}
