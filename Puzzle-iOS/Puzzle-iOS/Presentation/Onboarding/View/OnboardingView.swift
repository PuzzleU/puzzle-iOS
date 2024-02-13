//
//  OnboardingView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/13/24.
//

import UIKit

class OnboardingView: UIView {

    // MARK: - UI Components

    private let nextButton = PuzzleMainButton(title: StringLiterals.Onboarding.next)
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI & Layout
    
    private func setUI() {
        self.backgroundColor = .puzzleRealWhite
        addSubview(nextButton)
    }
    
    private func setLayout() {
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(51)
            $0.centerX.equalToSuperview()
        }
    }

}
