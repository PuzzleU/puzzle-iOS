//
//  PuzzleMainButton.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/9/24.
//

import UIKit

import SnapKit
import Then

final class PuzzleMainButton: UIButton {
    
    // MARK: - Life Cycle
    
    override var isSelected: Bool {
        didSet {
            updateButtonUI()
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        
        setUI(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        setLayout()
    }
    
    // MARK: - UI & Layout
    
    private func setUI(title: String) {
        setTitle(title, for: .normal)
        titleLabel?.font = .body2
        setTitleColor(.puzzleRealWhite, for: .normal)
        backgroundColor = .puzzleGray300
        layer.cornerRadius = 15
//        addTarget(self, action: #selector(selectedButton), for: .touchUpInside)
    }
    
    private func setLayout() {
        guard let superview = superview else { return }
        self.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(22)
            $0.height.equalTo(52)
            $0.bottom.equalTo(superview.safeAreaLayoutGuide.snp.bottom).offset(-17)
        }
    }
    
    // MARK: - Custom methods
    
//    @objc 
//    private func selectedButton() {
//        isSelected.toggle()
//    }
    
    private func updateButtonUI() {
        backgroundColor = isSelected ? .puzzlePurple : .puzzleGray300
    }
}
