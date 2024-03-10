//
//  UITextField+Combine.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/1/24.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        publisher(for: .editingChanged)
            .compactMap { $0 }
            .map { $0.text! }
            .eraseToAnyPublisher()
    }
}
