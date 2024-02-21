//
//  OnboardingBaseView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/13/24.
//

import UIKit

final class OnboardingBaseView: UIView {
    
    // MARK: - UI Components
    
    private let nextButton = PuzzleMainButton(title: StringLiterals.Onboarding.next)
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        backgroundColor = .puzzleRealWhite
        addSubview(nextButton)
    }
    
    // MARK: - Methods
    
    /// 버튼을 최상단으로 올리는 코드 입니다.
    func bringNextButtonToFront() {
        bringSubviewToFront(nextButton)
    }
}
