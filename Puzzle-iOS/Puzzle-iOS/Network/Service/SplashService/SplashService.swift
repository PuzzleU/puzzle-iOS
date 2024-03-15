//
//  SplashService.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 3/15/24.
//

import Foundation
import Combine

protocol SplashService {
    func getLoginData() -> AnyPublisher<UserResult, Error>
}
final class DefaultSplashService {
    private let 
}
