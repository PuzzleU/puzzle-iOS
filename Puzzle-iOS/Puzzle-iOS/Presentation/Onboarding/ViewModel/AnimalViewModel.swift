//
//  AnimalViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit
import Combine

class AnimalsViewModel: ViewModelType {
    
    // MARK: - Properties
    @Published var animalImages: [UIImage] = []
    let backButtonTapped = PassthroughSubject<Void, Never>()
    let buttonIsValidSubject: PassthroughSubject<Bool, Never> = .init()
    
    // MARK: - Inputs
    
    struct Input {
        let viewDidAppear: AnyPublisher<Void, Never>
        let imagePublisher: AnyPublisher<Int, Never>
    }
    
    // MARK: - Outputs
    
    struct Output {
        let buttonIsValid: AnyPublisher<Bool, Never>
    }
    
    private let onboardingServiceType: OnboardingServiceType
    
    // MARK: - init
    
    init(onboardingServiceType: OnboardingServiceType = OnboardingService()) {
        self.onboardingServiceType = onboardingServiceType
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewDidAppear
            .flatMap { [unowned self] _ in
                onboardingServiceType.getAnimalImage()
                    .collect()
                    .catch { error -> Just<[UIImage]> in
                        print("error \(error)")
                        return Just([])
                    }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] images in
                self?.animalImages = images
                print("‼️‼️images\(images)‼️‼️")
            })
            .store(in: cancelBag)
        
        let buttonIsValid: AnyPublisher<Bool, Never> = input.imagePublisher.flatMap { value in
            print("OnboardingSelectProfileImageVC 의 \(value) 터치 ")
            return Just(true)
        }.eraseToAnyPublisher()
        
        return Output(buttonIsValid: buttonIsValid)
    }
    
}
