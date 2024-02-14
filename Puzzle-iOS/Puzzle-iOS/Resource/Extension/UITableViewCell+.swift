//
//  UITableViewCell+.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/14/24.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier : String {
        return String(describing: self)
    }
}
