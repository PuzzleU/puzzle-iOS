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
    
    @Published var competitionKeywords: [InterestKeyword] = []
    @Published var jobKeywords: [InterestKeyword] = []
    @Published var studyKeywords: [InterestKeyword] = []
    
    @Published var selectedKeywords: Set<Int> = []
    
    let nextButtonTapped = PassthroughSubject<Void, Never>()
    let backButtonTapped = PassthroughSubject<Void, Never>()
    private let onboardingServiceType: SplashService
    
    var cancel = CancelBag()
    
    // MARK: - Inputs
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let selectKeyWordIndex: AnyPublisher<Int, Never>
    }
    
    // MARK: - Outputs
    
    struct Output {
        let selectkeywordIndex: AnyPublisher<Set<Int>, Never>
    }
    
    // MARK: - init
    
    init(onboardingServiceType: SplashService = OnboardingService()) {
        self.onboardingServiceType = onboardingServiceType
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewDidLoad
            .flatMap { [unowned self] _ in self.onboardingServiceType.getOnboardingData() }
            .map { [unowned self] responseData in
                self.competitionKeywords = responseData.response.interestList.first { $0.interestType == "Competition" }?.interestList
                    .map { InterestKeyword(name: $0.interestName, id: $0.interestId) } ?? []
                self.jobKeywords = responseData.response.interestList.first { $0.interestType == "Job" }?.interestList.map { InterestKeyword(name: $0.interestName, id: $0.interestId) } ?? []
                self.studyKeywords = responseData.response.interestList.first { $0.interestType == "Study" }?.interestList.map { InterestKeyword(name: $0.interestName, id: $0.interestId) } ?? []
            }
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: cancelBag)
        
        let selectedIndexPathPublisher = input.selectKeyWordIndex
            .flatMap { [unowned self] indexPath -> AnyPublisher<Set<Int>, Never> in
                if self.selectedKeywords.contains(indexPath) {
                    self.selectedKeywords.remove(indexPath)
                } else if self.selectedKeywords.count < 6 {
                    self.selectedKeywords.insert(indexPath)
                }
                return Just(selectedKeywords).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        return Output(selectkeywordIndex: selectedIndexPathPublisher)
    }
}
