//
//  UIViewController+Combine.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/29/24.
//

import UIKit
import Combine

extension UIViewController {
    var viewDidLoadPublisher: AnyPublisher<Void, Never> {
        let selector = #selector(UIViewController.viewDidLoad)
        return Just(selector)
            .map { _ in Void() }
            .eraseToAnyPublisher()
    }
}
