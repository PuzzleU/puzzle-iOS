//
//  OnboardingViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/13/24.
//

import Combine

class OnboardingTextViewModel {
    
    // MARK: - Properties
    
    @Published var userName: String = ""
    @Published var userId: String = ""
    
    // 뒤로가기 버튼 액션을 처리하기 위한 PassthroughSubject
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
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
