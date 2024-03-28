//
//  InterestViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/18/24.
//

import UIKit
import Combine

struct Interest {
    let competition: [String]
    let job: [String]
    let study: [String]
}

class InterestViewModel: ViewModelType {
    
    // MARK: - Properties
    
    @Published var competitions: [String] = []
    @Published var jobs: [String] = []
    @Published var studys: [String] = []
    
    @Published var selectedKeywords: Set<IndexPath> = []
    
    let nextButtonTapped = PassthroughSubject<Void, Never>()
    let backButtonTapped = PassthroughSubject<Void, Never>()
    private let onboardingServiceType: SplashService
    
    var cancel = CancelBag()
    
    // MARK: - Inputs
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let selectKeyWordIndex: AnyPublisher<IndexPath, Never>
    }
    
    // MARK: - Outputs
    
    struct Output {
        let selectkeywordIndex: AnyPublisher<Set<IndexPath>, Never>
    }
    
    // MARK: - init
    
    init(onboardingServiceType: SplashService = OnboardingService()) {
        self.onboardingServiceType = onboardingServiceType
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        input.viewDidLoad
            .flatMap { [unowned self] _ in
                self.onboardingServiceType.getOnboardingData()
            }
            .map { interestData -> (competitions: [String], jobs: [String], studies: [String]) in
                var competitions = [String]()
                var jobs = [String]()
                var studies = [String]()
                
                for interest in interestData.response.interestList {
                    switch interest.interestType {
                    case "Competition":
                        competitions.append(contentsOf: interest.interestList.map { $0.interestName })
                    case "Job":
                        jobs.append(contentsOf: interest.interestList.map { $0.interestName })
                    case "Study":
                        studies.append(contentsOf: interest.interestList.map { $0.interestName })
                    default:
                        break
                    }
                }
                
                return (competitions, jobs, studies)
            }
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] interest in
                self?.competitions = interest.competitions
                self?.jobs = interest.jobs
                self?.studys = interest.studies
            })
            .store(in: cancelBag)
        
        let selectedIndexPathPublisher = input.selectKeyWordIndex
            .flatMap { [unowned self] indexPath -> AnyPublisher<Set<IndexPath>, Never> in
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
