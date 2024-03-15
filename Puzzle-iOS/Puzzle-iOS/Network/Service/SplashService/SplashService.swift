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

final class DefaultUSplashService: NSObject, Networking {
    private var urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default,
                                                    delegate: nil,
                                                    delegateQueue: nil)
}

extension DefaultUSplashService: SplashService {
    func getLoginData() -> AnyPublisher<SplashDTO, Error> {
        do {
            let request = try makeHTTPRequest(path: URLs.Login.splash,
                                              method: .get,
                                              headers: APIConstants.noTokenHeader,
                                              body: nil)
            
            NetworkLogger.log(request: request)
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map { $0.data }
                .decode(type: SplashDTO.self, decoder: JSONDecoder())
                .mapError { $0 }
                .eraseToAnyPublisher()
            
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
