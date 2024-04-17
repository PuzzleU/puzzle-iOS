//
//  PositionViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit
import Combine

struct PositionKeyword {
    let id: Int
    let positionImage: UIImage
}

class PositionViewModel: ViewModelType {
    
    // MARK: - Properties
    
    @Published var selectedPositionIndexes: Set<Int> = []
    
    let nextButtonTapped = PassthroughSubject<Void, Never>()
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
    private let onboardingServiceType: SplashService
    
    // MARK: - Inputs
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let selectImageAtIndex: AnyPublisher<Int, Never>
    }
    
    // MARK: - Outputs
    
    struct Output {
        let positionImage: AnyPublisher<[PositionKeyword], Never>
        let selectedIndices: AnyPublisher<Set<Int>, Never>
    }
    
    // MARK: - init
    
    init(onboardingServiceType: SplashService = OnboardingService()) {
        self.onboardingServiceType = onboardingServiceType
    }
    
    // MARK: - Methods
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        
        let positionImagesPublisher = input.viewDidLoad
            .flatMap { [unowned self] _ -> AnyPublisher<[PositionKeyword], Never> in
                self.onboardingServiceType.getOnboardingData()
                    .flatMap { splashData -> AnyPublisher<[PositionKeyword], Never> in
                        let profileURLs = splashData.response.positionList
                        let imagePublishers = profileURLs.map { position -> AnyPublisher<PositionKeyword, Never> in
                            guard let url = URL(string: position.positionUrl) else {
                                return Just(PositionKeyword(id: position.positionId, positionImage: UIImage())).eraseToAnyPublisher()
                            }
                            return self.loadImage(from: url)
                                .map { PositionKeyword(id: position.positionId, positionImage: $0) }
                                .eraseToAnyPublisher()
                        }
                        return Publishers.MergeMany(imagePublishers)
                            .collect()
                            .eraseToAnyPublisher()
                    }
                    .replaceError(with: []) // 오류 처리
                    .eraseToAnyPublisher()
            }
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
    
    private func loadImage(from url: URL?) -> AnyPublisher<UIImage, Never> {
        guard let url = url else {
            return Just(UIImage()).eraseToAnyPublisher() // URL이 유효하지 않은 경우 빈 UIImage 반환
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ in UIImage(data: data) ?? UIImage() }
            .replaceError(with: UIImage())
            .eraseToAnyPublisher()
    }
}
