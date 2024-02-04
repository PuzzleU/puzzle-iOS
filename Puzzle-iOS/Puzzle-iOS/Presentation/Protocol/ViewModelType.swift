//
//  ViewModelType.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/3/24.
//

import Foundation
import Combine

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(from input: Input, cancelBag: CancelBag) -> Output
}
