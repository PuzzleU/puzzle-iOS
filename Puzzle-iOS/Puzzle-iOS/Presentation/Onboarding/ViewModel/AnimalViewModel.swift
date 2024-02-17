//
//  AnimalViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit
import Combine

class AnimalsViewModel {
    @Published var animalImages: [UIImage] = []
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
    init() {
        loadImages()
    }
    
    private func loadImages() {
        let imageNames = ["imgMouse", "imgFox", "imgDog", "imgTiger", "imgOx", "imgLion", "imgPanda", "imgMonkey", "imgRabbit", "imgBear", "imgCat", "imgRobot"]
        animalImages = imageNames.compactMap { UIImage(named: $0) }
    }
}

