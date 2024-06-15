//
//  UITextView+Combine.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/19/24.
//

import UIKit
import Combine

extension UITextView {
    /// text view 의 text가 변동될때 마다. 호출 되는 퍼블리셔
    var textDidChangePublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification, object: self)
            .compactMap { notification -> String? in
                (notification.object as? UITextView)?.text
            }
            .eraseToAnyPublisher()
    }
    
    /// text view 시작할때 호출되는 퍼블리셔
    var textDidBeginEditingPublisher: AnyPublisher<Void, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidBeginEditingNotification, object: self)
            .map { _ in Void() }
            .eraseToAnyPublisher()
    }
    
    /// text view 끝날때 호출되는 퍼블리셔 퍼블리셔
    var textDidEndEditingPublisher: AnyPublisher<Void, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidEndEditingNotification, object: self)
            .map { _ in Void() }
            .eraseToAnyPublisher()
    }
}
