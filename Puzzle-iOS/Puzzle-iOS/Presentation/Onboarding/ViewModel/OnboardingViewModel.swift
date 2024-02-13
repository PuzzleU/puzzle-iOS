//
//  OnboardingViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/13/24.
//
import Foundation
import Combine

class OnboardingViewModel {
    
    @Published var textFieldOnboarding: String = ""
    
    struct Input {
        let textFieldOnboarding: AnyPublisher<String, Never>
    }
    
    struct Output {
        let buttonIsValid: AnyPublisher<Bool, Never>
    }
    
//    func transform(from input: Input, cancelBag: CancelBag) -> Output {
//        
//    }
    // 각 텍스트 필드의 입력 값을 저장할 프로퍼티
    private var cancelBag = CancelBag()
}
