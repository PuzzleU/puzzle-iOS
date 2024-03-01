//
//  PositionViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit
import Combine

class PositionViewModel: ViewModelType {
    
    // MARK: - Properties
    
    @Published var positionImages: [UIImage] = []
    @Published var selectedPositionIndexes: Set<Int> = []
    
    let nextButtonTapped = PassthroughSubject<Void, Never>()
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
    private let onboardingServiceType: OnboardingServiceType
    
    // MARK: - Inputs
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let selectImageAtIndex: AnyPublisher<Int, Never>
    }
    
    // MARK: - Outputs
    
    struct Output {
        let positionImage: AnyPublisher<[UIImage], Never>
        let selectedIndices: AnyPublisher<Set<Int>, Never>
    }
    
    // MARK: - init
    
    init(onboardingServiceType: OnboardingServiceType = OnboardingService()) {
        self.onboardingServiceType = onboardingServiceType
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        
        let positionImagesPublisher = input.viewDidLoad
            .flatMap { [unowned self] _ in
                self.onboardingServiceType.getPositionImage()
                    .collect()
                    .catch { _ in Just(self.positionImages) }
                    .eraseToAnyPublisher()
            }
            .share()
            .eraseToAnyPublisher()
        
        let selectedIndicesPublisher = input.selectImageAtIndex
            .flatMap { [unowned self] index -> AnyPublisher<Set<Int>, Never> in
                if selectedPositionIndexes.contains(index) {
                    selectedPositionIndexes.remove(index)
                } else if selectedPositionIndexes.count < 2 {
                    selectedPositionIndexes.insert(index)
                }
                return Just(selectedPositionIndexes).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        return Output(positionImage: positionImagesPublisher,
                      selectedIndices: selectedIndicesPublisher)
        
    }
}
