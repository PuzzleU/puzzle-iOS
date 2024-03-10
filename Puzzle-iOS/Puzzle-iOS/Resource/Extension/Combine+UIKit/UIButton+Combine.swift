//
//  UIButton+Combine.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/1/24.
//

import UIKit
import Combine

extension UIButton {
    var tapPublisher: AnyPublisher<Void, Never> {
        publisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
