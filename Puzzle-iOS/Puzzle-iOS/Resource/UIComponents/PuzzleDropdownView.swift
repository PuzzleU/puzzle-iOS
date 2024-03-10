//
//  PuzzleDropdownView.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/14/24.
//

import UIKit

import SnapKit
import Then

final class PuzzleDropdownView: UIView {
    
    // MARK: - UI Components
    
    let dropdownView = UIView().then {
        $0.backgroundColor = .puzzleWhite
        $0.layer.borderColor = UIColor.puzzleGray300.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
    
    let dropdownLabel = UILabel().then {
        $0.font = .body2
        $0.textColor = .puzzleWhite
    }
    
    private let dropdownImageView = UIImageView(image: .dropdown)
    
    // MARK: - Life Cycles
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = .clear
        
        bindTitle(title: title)
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    func bindTitle(title: String) {
        dropdownLabel.text = title
    }
    
    private func setHierarchy() {
        self.addSubview(dropdownView)
        dropdownView.addSubviews(dropdownLabel,
                                 dropdownImageView)
    }
    
    private func setLayout() {
        dropdownView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dropdownLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
        }
        
        dropdownImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(18)
            $0.size.equalTo(9)
        }
    }
}
