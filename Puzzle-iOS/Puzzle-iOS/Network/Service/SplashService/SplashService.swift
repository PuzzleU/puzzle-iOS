//
//  SplashService.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 3/15/24.
//

import Foundation
import Combine

protocol SplashService {
    func getOnboardingData() -> AnyPublisher<SplashDTO, Error>
    func requestOnboardingUserInfo(data: UserInfoDTO) ->  AnyPublisher<Void, Error>
}

final class OnboardingService: NSObject, Networking, SplashService {
    func getOnboardingData() -> AnyPublisher<SplashDTO, Error> {
        do {
            let request = try makeHTTPRequest(path: URLs.Login.splash,
                                              method: .get,
                                              headers: APIConstants.noTokenHeader,
                                              body: nil)
            
            NetworkLogger.log(request: request)
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: SplashDTO.self, decoder: JSONDecoder())
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
            
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func requestOnboardingUserInfo(data: UserInfoDTO) -> AnyPublisher<Void, Error> {
        do {
            let body = try JSONEncoder().encode(data)
            let request = try makeHTTPRequest(path: URLs.Login.essential,
                                              method: .patch,
                                              headers: APIConstants.noTokenHeader,
                                              body: body)
            
            NetworkLogger.log(request: request)
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map { _ in () }
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
            
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
}
