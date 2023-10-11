//
//  UITextField.swift
//  Puzzle
//
//  Created by 신지원 on 2023/10/12.
//

import UIKit

extension UITextField {
    
    func addLeftPadding(inset: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func addRightPadding(inset: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
    
    func isEmpty() -> Bool {
        if let text = self.text, !text.isEmpty {
            return false
        } else {
            return true
        }
    }
}

