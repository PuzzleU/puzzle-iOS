//
//  LoginViewModel.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/3/24.
//

import Foundation
import Combine

import AuthenticationServices

import KakaoSDKAuth
import KakaoSDKUser

final class LoginViewModel: NSObject, ViewModelType {
    
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
        input.kakaoTapped
            .sink {
                self.requestKakaoLogin()
            }
            .store(in: cancelBag)
        
        input.appleTapped
            .sink {
                self.requestAppleLogin()
            }
            .store(in: cancelBag)
        
        return Output(userInfoPublisher: userInfoPublisher)
    }
    
    // MARK: - Kakao Login
    
    private func requestKakaoLogin() {
        
        // 카카오톡이 설치되어 있을 때
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else if let token = oauthToken {
                    print("카카오 톡으로 로그인 성공💫")
                    self.getKakaoLoginUserData(oauthToken: token)
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
                    self.getKakaoLoginUserData(oauthToken: token)
                } else {
                    print("OAuth 토큰을 받지 못했습니다")
                }
            }
        }
    }
    
    private func getKakaoLoginUserData(oauthToken: OAuthToken) {
        UserApi.shared.me { user, error in
            if let error = error {
                print(error)
            } else {
                let token = oauthToken.accessToken
                guard let email = user?.kakaoAccount?.email,
                      let name = user?.kakaoAccount?.profile?.nickname
                else {
                    print("email, name 을 받지 못했습니다.")
                    return
                }
                
                //TODO: - 서버에 토큰 보내는 코드
            }
        }
    }
}

    //MARK: - Apple Login

extension LoginViewModel: ASAuthorizationControllerDelegate {
    private func requestAppleLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        authorizationController.performRequests()
    }
    
    /// 애플 로그인 성공
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            /// Applie ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            /// 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            guard let identityToken = appleIDCredential.identityToken,
                  let tokenStr = String(data: identityToken, encoding: .utf8) else { return }
            
            print("User ID : \(String(describing: userIdentifier))")
            print("token : \(String(describing: tokenStr))")
            
            // TODO: - 애플 로그인 서버 연동
            userInfoPublisher.send(true)
        default:
            break
        }
    }
    
    /// 애플 로그인 실패 처리
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("[🍎] Apple Login error - \(error.localizedDescription)")
    }
}
