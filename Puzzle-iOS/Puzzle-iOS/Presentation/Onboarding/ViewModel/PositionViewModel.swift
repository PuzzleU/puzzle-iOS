//
//  PositionViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit
import Combine

class PositionViewModel {
    @Published var positionImages: [UIImage] = []
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
    init() {
        loadImages()
    }
    
    private func loadImages() {
        let positionNames = ["imgDevelop", "imgPM", "imgMarketing", "imgDesign", "imgData", "imgMiscellaneous"]
        positionImages = positionNames.compactMap { UIImage(named: $0) }
    }
}
