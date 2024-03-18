//
//  SplashService.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 3/15/24.
//

import Foundation
import Combine

protocol SplashService {
    func getLoginData() -> AnyPublisher<SplashDTO, Error>
}

final class DefaultSplashService: NSObject, Networking, SplashService {
    func getLoginData() -> AnyPublisher<SplashDTO, Error> {
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
}
