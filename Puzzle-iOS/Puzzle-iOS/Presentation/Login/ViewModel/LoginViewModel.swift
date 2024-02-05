//
//  LoginViewModel.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/3/24.
//

import Foundation
import Combine

final class LoginViewModel: ViewModelType {
    
    private let cancelBag = CancelBag()
    private let userInfoPublisher = PassthroughSubject<Bool, Never>()
    static let kakaoKEY: String = Bundle.main.object(forInfoDictionaryKey: Config.Keys.Plist.kakaoKey) as? String ?? "오잉"
    
    struct Input {
        let kakaoTapped: AnyPublisher<Void, Never>
        let appleTapped: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let userInfoPublisher: PassthroughSubject<Bool, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.kakaoTapped
            .sink {
                print("카카오 로그인 시작되는 코드")
                print(LoginViewModel.kakaoKEY)
            }
            .store(in: cancelBag)
        
        input.appleTapped
            .sink {
                print("애플 로그인 시작되는 코드")
            }
            .store(in: cancelBag)
        
        return Output(userInfoPublisher: userInfoPublisher)
    }
}
