//
//  AreaViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/18/24.
//

import Combine

class AreaViewModel {
    
    // MARK: - Properties

    let backButtonTapped = PassthroughSubject<Void, Never>()
    let locationTapGesture = PassthroughSubject<Void, Never>()
    private var cancelBag = CancelBag()

    @Published var Areas: [String] = []

    init() {
        loadDatas()
    }

    private func loadDatas() {
        let area = ["서울", "경기", "제주", "강원", "인천", "부산", "춘천", "등등.."]
        Areas = area.compactMap { $0 }
    }

}
