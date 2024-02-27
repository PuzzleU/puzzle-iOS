//
//  InputNameViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/13/24.
//

import Combine

class InputNameViewModel: ViewModelType {

    // MARK: - Properties
    
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
    struct Input {
        let namePublisher: AnyPublisher<String, Never>
        let backgroundTapPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let buttonIsValid: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let buttonIsValidPublisher = input.namePublisher.flatMap { name in
            if name.count >= 2 && name.count <= 12 {
                return Just(true)
            } else {
                return Just(false)
            }
        }.eraseToAnyPublisher()
        
        return Output(buttonIsValid: buttonIsValidPublisher)
    }
}
