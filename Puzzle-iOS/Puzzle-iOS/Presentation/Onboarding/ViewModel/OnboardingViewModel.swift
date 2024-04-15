//
//  OnboardingViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/9/24.
//

import Foundation

import Combine

struct UserInfoDTO: Codable {
    var userKoreaName: String?
    var userPuzzleId: String?
    var userProfileId: Int?
    var userPositionIDs: [Int]?
    var userInterestIdList: [Int]?
    var userLocationIdList: [Int]?
}

final class OnboardingViewModel: ViewModelType {
    
    var cancelBag = CancelBag()
    
    var userName: String = ""
    var userId: String = ""
    var userProfile: Int = 0
    var userPosition: [Int] = []
    var userInterest: [Int] = []
    var userLocation: [Int] = []
    
    struct Input {
        let finishedButtonTapped: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let userInfoSend: AnyPublisher<Void, Error>
    }
    
    private var onboardingServiceType: SplashService
    
    // MARK: - init
    
    init(onboardingServiceType: SplashService = OnboardingService()) {
        self.onboardingServiceType = onboardingServiceType
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let userInfo = UserInfoDTO(
            userKoreaName: userName,
            userPuzzleId: userId,
            userProfileId: userProfile,
            userPositionIDs: userPosition,
            userInterestIdList: userInterest,
            userLocationIdList: userLocation
        )
        
        let essentialData = input.finishedButtonTapped
            .flatMap { [unowned self] _ -> AnyPublisher<Void, Error> in
                self.onboardingServiceType.requestOnboardingUserInfo(data: userInfo)
            }
            .catch { error -> AnyPublisher<Void, Error> in
                print("Error sending user info: \(error)")
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        return Output(userInfoSend: essentialData)
    }
}
