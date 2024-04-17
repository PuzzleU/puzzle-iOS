//
//  InputIdViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/28/24.
//

import Combine

class InputIdViewModel: ViewModelType {
    
    // MARK: - Properties
    
    private let minimumLength: Int = 2
    private let idMaximumLength: Int = 20
    
    let nextButtonTapped = PassthroughSubject<Void, Never>()
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
    
    // MARK: - Methods
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let initialValidation = Just(false).eraseToAnyPublisher()
        
        let buttonIsValidPublisher = input.idPublisher.flatMap { [unowned self] name in
            if name.count >= minimumLength && name.count <= idMaximumLength {
                return Just(true)
            } else {
                return Just(false)
            }
        }.prepend(initialValidation).eraseToAnyPublisher()
        
        return Output(buttonIsValid: buttonIsValidPublisher)
    }
}
