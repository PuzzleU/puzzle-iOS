//
//  ProfileViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit
import Combine

class ProfileViewModel: ViewModelType {
    
    // MARK: - Properties
    
    @Published var animalImages = [UIImage]()
    
    let nextButtonTapped = PassthroughSubject<Void, Never>()
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
    // MARK: - Inputs
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let selectImageAtIndex: AnyPublisher<Int, Never>
    }
    
    // MARK: - Outputs
    
    struct Output {
        let animalImages: AnyPublisher<[UIImage], Never>
        let selectedImageIndex: AnyPublisher<Int?, Never>
    }
    
    private let onboardingServiceType: OnboardingServiceType
    
    // MARK: - init
    
    init(onboardingServiceType: OnboardingServiceType = OnboardingService()) {
        self.onboardingServiceType = onboardingServiceType
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let animalImagesPublisher = input.viewDidLoad
            .flatMap { [unowned self] _ in
                self.onboardingServiceType.getAnimalImage()
                    .collect()
                    .catch { _ in Just(self.animalImages) }
                    .eraseToAnyPublisher()
            }
            .share()
            .eraseToAnyPublisher()
        
        // 이 부분에서 selectImageAtIndex 입력을 받아서 처리
        let selectedImageIndexPublisher = input.selectImageAtIndex
            .map { Optional($0) }
            .eraseToAnyPublisher()
        
        return Output(
            animalImages: animalImagesPublisher,
            selectedImageIndex: selectedImageIndexPublisher
        )
    }
}
