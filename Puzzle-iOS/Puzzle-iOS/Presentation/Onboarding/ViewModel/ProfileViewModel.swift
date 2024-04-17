//
//  ProfileViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit
import Combine

struct ProfileImage {
    let id: Int
    let profileImage: UIImage
}

class ProfileViewModel: ViewModelType {
    
    // MARK: - Properties
    
    let nextButtonTapped = PassthroughSubject<Void, Never>()
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
    // MARK: - Inputs
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let selectImageAtIndex: AnyPublisher<Int, Never>
    }
    
    // MARK: - Outputs
    
    struct Output {
        let animalImages: AnyPublisher<[ProfileImage], Never>
        let selectedImageIndex: AnyPublisher<Int?, Never>
    }
    
    private let onboardingServiceType: SplashService
    
    // MARK: - init
    
    init(onboardingServiceType: SplashService = OnboardingService()) {
        self.onboardingServiceType = onboardingServiceType
    }
    
    // MARK: - Methods
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let animalImagesPublisher = input.viewDidLoad
            .flatMap { [unowned self] _ -> AnyPublisher<[ProfileImage], Never> in
                self.onboardingServiceType.getOnboardingData()
                    .flatMap { splashData -> AnyPublisher<[ProfileImage], Never> in
                        let profileURLs = splashData.response.profileList
                        let imagePublishers = profileURLs.map { profile -> AnyPublisher<ProfileImage, Never> in
                            guard let url = URL(string: profile.profileUrl) else {
                                return Just(ProfileImage(id: profile.profileId, profileImage: UIImage())).eraseToAnyPublisher()
                            }
                            return self.loadImage(from: url)
                                .map { ProfileImage(id: profile.profileId, profileImage: $0) }
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
        
        let selectedImageIndexPublisher = input.selectImageAtIndex
            .map { Optional($0) }
            .eraseToAnyPublisher()
        
        return Output(
            animalImages: animalImagesPublisher,
            selectedImageIndex: selectedImageIndexPublisher
        )
    }
    
    private func loadImage(from url: URL) -> AnyPublisher<UIImage, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ -> UIImage in
                UIImage(data: data) ?? UIImage()
            }
            .replaceError(with: UIImage()) // 오류가 발생하면 빈 이미지 반환
            .eraseToAnyPublisher()
    }
}
