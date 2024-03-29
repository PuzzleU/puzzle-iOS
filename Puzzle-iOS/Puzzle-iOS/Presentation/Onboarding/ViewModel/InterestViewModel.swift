//
//  InterestViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/18/24.
//

import UIKit
import Combine

struct InterestKeyword {
    let name: String
    let id: Int
}
class InterestViewModel: ViewModelType {
    
    // MARK: - Properties
    
    @Published var selectedKeywords: Set<Int> = [] // 키워드 관련 로직 담당하는 변수 입니다.
    
    let nextButtonTapped = PassthroughSubject<Void, Never>()
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
    private let onboardingServiceType: SplashService
    
    // MARK: - Inputs
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let selectKeyWordIndex: AnyPublisher<Int, Never>
    }
    
    // MARK: - Outputs
    
    struct Output {
        let competitionKeywords: AnyPublisher<[InterestKeyword], Never>
        let jobKeywords: AnyPublisher<[InterestKeyword], Never>
        let studyKeywords: AnyPublisher<[InterestKeyword], Never>
        let selectkeywordIndex: AnyPublisher<Set<Int>, Never>
    }
    
    // MARK: - init
    
    init(onboardingServiceType: SplashService = OnboardingService()) {
        self.onboardingServiceType = onboardingServiceType
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let competitionKeywordsPublisher = input.viewDidLoad
            .flatMap { [unowned self] _ in
                self.onboardingServiceType.getOnboardingData()
                    .map { responseData -> [InterestKeyword] in
                        responseData.response.interestList.first { $0.interestType == "Competition" }?.interestList
                            .map { InterestKeyword(name: $0.interestName, id: $0.interestId) } ?? []
                    }
                    .catch { _ in Just<[InterestKeyword]>([]) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        let jobKeywordsPublisher = input.viewDidLoad
            .flatMap { [unowned self] _ in
                self.onboardingServiceType.getOnboardingData()
                    .map { responseData -> [InterestKeyword] in
                        responseData.response.interestList.first { $0.interestType == "Job" }?.interestList
                            .map { InterestKeyword(name: $0.interestName, id: $0.interestId) } ?? []
                    }
                    .catch { _ in Just<[InterestKeyword]>([]) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        let studyKeywordsPublisher = input.viewDidLoad
            .flatMap { [unowned self] _ in
                self.onboardingServiceType.getOnboardingData()
                    .map { responseData -> [InterestKeyword] in
                        responseData.response.interestList.first { $0.interestType == "Study" }?.interestList
                            .map { InterestKeyword(name: $0.interestName, id: $0.interestId) } ?? []
                    }
                    .catch { _ in Just<[InterestKeyword]>([]) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        let selectedIndexPathPublisher = input.selectKeyWordIndex
            .flatMap { [unowned self] indexPath -> AnyPublisher<Set<Int>, Never> in
                if self.selectedKeywords.contains(indexPath) {
                    self.selectedKeywords.remove(indexPath)
                } else if self.selectedKeywords.count < 6 {
                    self.selectedKeywords.insert(indexPath)
                }
                return Just(self.selectedKeywords).eraseToAnyPublisher()
            }
            .print()
            .eraseToAnyPublisher()
        
        return Output(
            competitionKeywords: competitionKeywordsPublisher,
            jobKeywords: jobKeywordsPublisher,
            studyKeywords: studyKeywordsPublisher,
            selectkeywordIndex: selectedIndexPathPublisher
        )
    }
}
