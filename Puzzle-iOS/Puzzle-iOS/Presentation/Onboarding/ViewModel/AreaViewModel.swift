//
//  AreaViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/18/24.
//

import Combine

struct Area {
    let id: Int
    let name: String
}

class AreaViewModel: ViewModelType {
    
    // MARK: - Properties
    
    @Published var selectedAreaIndexes: Set<Int> = []
    
    let nextButtonTapped = PassthroughSubject<Void, Never>()
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
    private let splashService: SplashService
    
    // MARK: - Inputs
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let LocationTapPublisher: AnyPublisher<Int, Never>
    }
    
    // MARK: - Outputs
    
    struct Output {
        let locationListPublisher: AnyPublisher<[Area], Never>
        let tapLocationIndex: AnyPublisher<Set<Int>, Never>
    }
    
    private var cancelBag = CancelBag()
    
    // MARK: - init
    
    init(onboardingServiceType: SplashService = OnboardingService()) {
        splashService = onboardingServiceType
    }
    
    // MARK: - Methods
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let locationListPublisher = input.viewDidLoad
            .flatMap { [unowned self] _ in
                self.splashService.getOnboardingData()
            }.map { responseData -> [Area] in
                return responseData.response.locationList
                    .map {
                        Area(id: $0.locationId, name: $0.locationName)
                    }
            }
            .catch { _ in Just<[Area]>([]) }
            .print("🍀 LocationListPublisher 받은 데이터")
            .eraseToAnyPublisher()
        
        let tapLocationPublisher = input.LocationTapPublisher
            .flatMap { [unowned self] indexPath -> AnyPublisher<Set<Int>, Never> in
                if self.selectedAreaIndexes.contains(indexPath) {
                    self.selectedAreaIndexes.remove(indexPath)
                } else if self.selectedAreaIndexes.count < 3 {
                    self.selectedAreaIndexes.insert(indexPath)
                }
                return Just(self.selectedAreaIndexes).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        return Output(locationListPublisher: locationListPublisher, tapLocationIndex: tapLocationPublisher)
    }
    
}
