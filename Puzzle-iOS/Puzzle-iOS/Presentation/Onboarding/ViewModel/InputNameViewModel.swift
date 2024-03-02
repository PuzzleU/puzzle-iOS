//
//  InputNameViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/13/24.
//

import Combine

class InputNameViewModel: ViewModelType {
    
    // MARK: - Properties
    
    private let minimumLength: Int = 2
    private let nameMaximumLength: Int = 12
    
    let nextButtonTapped = PassthroughSubject<Void, Never>()
    
    // MARK: - Inputs
    
    struct Input {
        let namePublisher: AnyPublisher<String, Never>
        let backgroundTapPublisher: AnyPublisher<Void, Never>
    }
    
    // MARK: - Outputs
    
    struct Output {
        let buttonIsValid: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let initialValidation = Just(false).eraseToAnyPublisher()
        
        let buttonIsValidPublisher = input.namePublisher.flatMap { [unowned self] name in
            if name.count >= self.minimumLength && name.count <= self.nameMaximumLength {
                return Just(true)
            } else {
                return Just(false)
            }
        }.prepend(initialValidation).eraseToAnyPublisher()
        
        return Output(buttonIsValid: buttonIsValidPublisher)
    }
}
