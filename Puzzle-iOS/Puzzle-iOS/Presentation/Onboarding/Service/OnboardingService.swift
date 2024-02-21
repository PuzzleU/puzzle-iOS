//
//  File.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/19/24.
//

protocol OnboardingServiceType {
    func getAnimalImage() -> AnyPublisher<UIImage, Error>
}

import UIKit
import Combine

class OnboardingService: OnboardingServiceType {
    func getAnimalImage() -> AnyPublisher<UIImage, Error> {
        return animalProfile
            .publisher
            .catch { error in
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }.compactMap { UIImage(named: $0) }
            .eraseToAnyPublisher()
    }
}
