//
//  InputIdViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/28/24.
//

import Combine

class InputIdViewModel: ViewModelType {
    
    // MARK: - Properties
    
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
    // MARK: - Inputs
    
    struct Input {
        let idPublisher: AnyPublisher<String, Never>
        let backgroundTapPublisher: AnyPublisher<Void, Never>
    }
    
    // MARK: - Outputs
    
    struct Output {
        let buttonIsValid: AnyPublisher<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let buttonIsValidPublisher = input.idPublisher.flatMap { name in
            if name.count >= IntLiterals.InputValidationRule.minimumLength && name.count <= IntLiterals.InputValidationRule.idMaximumLength {
                return Just(true)
            } else {
                return Just(false)
            }
        }.eraseToAnyPublisher()
        
        return Output(buttonIsValid: buttonIsValidPublisher)
    }
}
