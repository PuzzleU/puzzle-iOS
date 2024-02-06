//
//  LoginViewModel.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/3/24.
//

import Foundation
import Combine

import KakaoSDKAuth
import KakaoSDKUser

final class LoginViewModel: ViewModelType {
    
    // MARK: - Properties
    
    private let cancelBag = CancelBag()
    private let userInfoPublisher = PassthroughSubject<Bool, Never>()
    
    // MARK: - Input, Output
    
    struct Input {
        let kakaoTapped: AnyPublisher<Void, Never>
        let appleTapped: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let userInfoPublisher: PassthroughSubject<Bool, Never>
    }
    
    // MARK: - Transform
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        
        //MARK: - Kakao Login
        
        input.kakaoTapped
            .sink {
                
                // 카카오톡이 설치되어 있을 때
                if UserApi.isKakaoTalkLoginAvailable() {
                    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                        if let error = error {
                            print(error)
                        } else if let token = oauthToken {
                            print("카카오 톡으로 로그인 성공💫")
                            self.getKaKaoUserAPI(oauthToken: token)
                        } else {
                            print("OAuth 토큰을 받지 못했습니다.")
                        }
                    }
                }
                
                // 카카오톡이 설치되어 있지 않을 때 -> 사파리로 연결
                else {
                    UserApi.shared.loginWithKakaoAccount{(oauthToken, error) in
                        if let error = error {
                            print(error)
                        } else if let token = oauthToken {
                            print("카카오 계정으로 로그인 성공💫")
                            self.getKaKaoUserAPI(oauthToken: token)
                        } else {
                            print("OAuth 토큰을 받지 못했습니다")
                        }
                    }
                }
            }
            .store(in: cancelBag)
        
        //MARK: - Apple Login
        
        input.appleTapped
            .sink {
                print("애플 로그인 시작되는 코드")
            }
            .store(in: cancelBag)
        
        return Output(userInfoPublisher: userInfoPublisher)
    }
    
    //MARK: - Get User API
    
    private func getKaKaoUserAPI(oauthToken: OAuthToken) {
        UserApi.shared.me { user, error in
            if let error = error {
                print(error)
            } else {
                let token = oauthToken.accessToken
                guard let email = user?.kakaoAccount?.email,
                      let name = user?.kakaoAccount?.profile?.nickname else{
                    print("email, name 을 받지 못했습니다.")
                    return
                }
                
                //TODO: - 서버에 토큰 보내는 코드
            }
        }
    }
}
