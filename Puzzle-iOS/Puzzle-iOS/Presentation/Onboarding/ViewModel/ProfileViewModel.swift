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
    
    private let onboardingServiceType: SplashService
    
    // MARK: - init
    
    init(onboardingServiceType: SplashService = OnboardingService()) {
        self.onboardingServiceType = onboardingServiceType
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let animalImagesPublisher = input.viewDidLoad
            .flatMap { [unowned self] _ -> AnyPublisher<[UIImage], Never> in
                self.onboardingServiceType.getOnboardingData()
                    .map { splashData -> [String] in
                        splashData.response.profileList.map { $0.profileUrl }
                    }
                    .print() // TODO: 배포시 삭제 코드
                    .flatMap { [unowned self] profileUrls -> AnyPublisher<[UIImage], Never> in
                        let imagePublishers = profileUrls.map { profileUrl in
                            self.loadImage(from: URL(string: profileUrl))
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
        
        let selectedImageIndexPublisher = input.selectImageAtIndex
            .map { Optional($0) }
            .eraseToAnyPublisher()
        
        return Output(
            animalImages: animalImagesPublisher,
            selectedImageIndex: selectedImageIndexPublisher
        )
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
