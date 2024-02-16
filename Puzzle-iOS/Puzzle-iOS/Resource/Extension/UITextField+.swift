//
//  UITextField+.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/15/24.
//
import UIKit

import Combine

extension UITextField {
    /// UITextField의 text 변화를 감지하는 Publisher 입니다.
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}
