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
        let positionImage: AnyPublisher<[UIImage], Never>
        let selectedIndices: AnyPublisher<Set<Int>, Never>
    }
    
    // MARK: - init
    
    init(onboardingServiceType: SplashService = OnboardingService()) {
        self.onboardingServiceType = onboardingServiceType
    }
    
    // MARK: - Methods
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        
        let positionImagesPublisher = input.viewDidLoad
            .flatMap { [unowned self] _ -> AnyPublisher<[UIImage], Never> in
                self.onboardingServiceType.getOnboardingData()
                    .map { splashData -> [String] in
                        splashData.response.positionList.map { $0.positionUrl }
                    }
                    .flatMap { [unowned self] postionUrls -> AnyPublisher<[UIImage], Never> in
                        let imagePublishers = postionUrls.map { postionUrl in
                            self.loadImage(from: URL(string: postionUrl))
                        }
                        // 모든 이미지 로딩 작업을 병렬로 수행하고, 결과를 하나의 배열로 모음
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
