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
    
    private let dropdownView = UIView().then {
        $0.backgroundColor = .puzzleRealWhite
        $0.layer.borderColor = UIColor.puzzleLightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
    
    private let dropdownLabel = UILabel().then {
        $0.font = .body2
        $0.textColor = .black
    }
    
    private let dropdownImageView = UIImageView(image: .dropdown)
    
    // MARK: - Life Cycles
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = .puzzleRealWhite
        
        bindTitle(title: title)
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI & Layout
    
    private func bindTitle(title: String) {
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
    
//    private func setGesture() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dropdownTapped))
//        dropdownView.addGestureRecognizer(tapGesture)
//    }
//    
//    @objc
//    private func dropdownTapped() {
//        dropdownTableView.isHidden.toggle()
//    }
}
