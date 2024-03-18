//
//  SplashRepository.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 3/15/24.
//

import Foundation
import Combine

protocol SplashRepository {
    func getLoginData() -> AnyPublisher<SplashDTO, Error>
}

struct DefaultSplashRepository: SplashRepository {
    
    private var splashService: SplashService
    
    init(splashService: SplashService) {
        self.splashService = splashService
    }
    
    func getLoginData() -> AnyPublisher<SplashDTO, Error> {
        return splashService.getLoginData()
    }
}
