//
//  File.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/19/24.
//

protocol OnboardingServiceType {
    func getAnimalImage() -> AnyPublisher<UIImage, Error>
    func getPositionImage() -> AnyPublisher<UIImage, Error>
    func getInterestKeyword() -> AnyPublisher<Interest, Error>
}

import UIKit
import Combine

class OnboardingService: OnboardingServiceType {
    func getAnimalImage() -> AnyPublisher<UIImage, Error> {
        Publishers.Sequence(sequence: animalProfile)
            .flatMap { imageName -> AnyPublisher<UIImage, Error> in
                guard let image = UIImage(named: imageName) else {
                    return Fail(error: NSError(domain: "ImageError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Image not found for \(imageName)"])).eraseToAnyPublisher()
                }
                return Just(image).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func getPositionImage() -> AnyPublisher<UIImage, Error> {
        Publishers.Sequence(sequence: positionImage)
            .flatMap { imageName -> AnyPublisher<UIImage, Error> in
                guard let image = UIImage(named: imageName) else {
                    return Fail(error: NSError(domain: "ImageError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Image not found for \(imageName)"])).eraseToAnyPublisher()
                }
                return Just(image).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func getInterestKeyword() -> AnyPublisher<Interest, Error> {
        Just(interest)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

}
