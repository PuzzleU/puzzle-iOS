//
//  InputNameViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/13/24.
//

import Combine

class InputNameViewModel: ViewModelType {
    
    // MARK: - Properties
    
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
        
        let buttonIsValidPublisher = input.namePublisher.flatMap { name in
            if name.count >= IntLiterals.InputValidationRule.minimumLength && name.count <= IntLiterals.InputValidationRule.nameMaximumLength {
                return Just(true)
            } else {
                return Just(false)
            }
        }.prepend(initialValidation).eraseToAnyPublisher()
        
        return Output(buttonIsValid: buttonIsValidPublisher)
    }
}
