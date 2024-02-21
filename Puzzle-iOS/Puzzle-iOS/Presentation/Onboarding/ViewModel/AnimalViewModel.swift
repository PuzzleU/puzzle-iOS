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
    
    struct Input {
        let viewDidAppear: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let touchImage: PassthroughSubject<Output, Never>
    }
    
    private let onboardingServiceType: OnboardingServiceType
    private let output: PassthroughSubject<Output, Never> = .init()
    
    private var cancelBag = CancelBag()
    
    @Published var animalImages: [UIImage] = []
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
    
    // MARK: - Life Cycles
    
    init(onboardingServiceType: OnboardingServiceType = OnboardingService()) {
        self.onboardingServiceType = onboardingServiceType
    }
    
    // MARK: - Methods
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewDidAppear
            .flatMap { [weak self] _ -> AnyPublisher<[UIImage], Never> in
                self?.onboardingServiceType.getAnimalImage()
                    .collect() // 배열 방출
                    .replaceError(with: []) // 에러 케이스
                    .eraseToAnyPublisher() ?? Just([]).eraseToAnyPublisher()
            }
            .assign(to: \.animalImages, on: self)
            .store(in: cancelBag)
        
        return Output(touchImage: output)
    }
    
}
