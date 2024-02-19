//
//  AnimalViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit
import Combine

class AnimalsViewModel: ViewModelType {
    
    struct Input {
        let viewDidAppear: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let touchImage: PassthroughSubject<Output, Never>
    }
    
    private let onboardingServiceType: OnboardingServiceType
    private let output: PassthroughSubject<Output, Never> = .init()
    
    private var cancelBag = CancelBag()
    
    init(onboardingServiceType: OnboardingServiceType = OnboardingService()) {
        self.onboardingServiceType = onboardingServiceType
    }
    
    // MARK: - Properties
    
    @Published var animalImages: [UIImage] = []
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewDidAppear
            .flatMap { [weak self] _ -> AnyPublisher<[UIImage], Never> in
                self?.onboardingServiceType.getAnimalImage()
                    .collect() // Collects all emitted images into an array
                    .replaceError(with: []) // In case of error, provides an empty array
                    .eraseToAnyPublisher() ?? Just([]).eraseToAnyPublisher()
            }
            .assign(to: \.animalImages, on: self)
            .store(in: cancelBag)
        
        return Output(touchImage: output)
    }
    
}
