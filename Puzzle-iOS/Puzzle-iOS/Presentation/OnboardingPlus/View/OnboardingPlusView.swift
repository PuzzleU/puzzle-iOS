//
//  OnboardingPlusView.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/9/24.
//

import UIKit

final class OnboardingPlusView: UIView {

    // MARK: - UI Components

    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .puzzleRealWhite
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
