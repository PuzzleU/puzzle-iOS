//
//  OnboardingBaseView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/13/24.
//

import UIKit
import Combine

final class OnboardingBaseView: UIView {
    
    // MARK: - UI Components
    
    private let nextButton = PuzzleMainButton(title: StringLiterals.Onboarding.next)
    
    var nextButtonTapped: PassthroughSubject<Void, Never> = .init()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        backgroundColor = .puzzleRealWhite
        addSubview(nextButton)
        
        isEnabledNextButton(isEnabled: false)
    }
    
    // MARK: - Methods
    
    /// 버튼을 최상단으로 올리는 코드 입니다.
    func bringNextButtonToFront() {
        bringSubviewToFront(nextButton)
    }
    
    func isEnabledNextButton(isEnabled: Bool) {
        nextButton.isSelected = isEnabled
        nextButton.isEnabled = isEnabled
    }
    
    // nextButton 이벤트를 바인딩하는 함수
    private func bind() {
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
    
    @objc private func nextButtonAction() {
        nextButtonTapped.send()
    }
}
