//
//  ProgressView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit

import SnapKit
import Then

class ProgressView: UIView {
    
    // MARK: - Properties
    
    private var totalSteps: Int
    private var currentStep: Int = 0 {
        didSet {
            updateProgress()
        }
    }
    
    // MARK: - UI Components
    
    private let progressView = UIProgressView(progressViewStyle: .bar).then {
        $0.layer.cornerRadius = 4
        $0.backgroundColor = .puzzleLightGray
        $0.progressTintColor = .puzzlePurple
        $0.setProgress(0, animated: false)
    }
    
    // MARK: - Life Cycles
    
    init(totalSteps: Int) {
        self.totalSteps = max(totalSteps, 1) // 최소 단계 수를 1로 설정하여 0으로 나누는 것을 방지
        
        super.init(frame: .zero)
        setProgressView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setProgressView() {
        addSubview(progressView)
        
        progressView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func updateProgress() {
        let progress = Float(currentStep) / Float(totalSteps)
        progressView.setProgress(progress, animated: true)
    }
    
    func setCurrentStep(_ step: Int) {
        self.currentStep = max(0, min(step, totalSteps)) // 현재 단계를 0과 totalSteps 사이로 제한
    }
}
