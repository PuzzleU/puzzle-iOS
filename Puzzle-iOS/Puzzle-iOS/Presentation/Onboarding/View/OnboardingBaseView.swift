//
//  OnboardingBaseView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/13/24.
//

import UIKit
import Combine

final class OnboardingBaseView: UIView {
    
    // MARK: - Property
    
    var nextButtonTapped: PassthroughSubject<Void, Never> = .init()
    private var cancelBag = CancelBag()
    
    // MARK: - UI Components
    
    private let nextButton = PuzzleMainButton(title: StringLiterals.Onboarding.next)
    
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
        backgroundColor = .puzzleWhite
        addSubview(nextButton)
        
        isEnabledNextButton(isEnabled: false)
    }
    
    // MARK: - Methods
    
    /// 버튼을 최상단으로 올리는 함수
    func bringNextButtonToFront() {
        bringSubviewToFront(nextButton)
    }
    
    func isEnabledNextButton(isEnabled: Bool) {
        nextButton.isSelected = isEnabled
        nextButton.isEnabled = isEnabled
    }
    
    private func bind() {
        nextButton.tapPublisher
            .sink { [unowned self] _ in
                nextButtonTapped.send()
            }.store(in: cancelBag)
    }
}
