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

    private let dropdownStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
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
    
    private let dropdownTableView = UITableView().then {
        $0.backgroundColor = .puzzleRealWhite
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.register(PuzzleDropDownTableViewCell.self, forCellReuseIdentifier: PuzzleDropDownTableViewCell.reuseIdentifier)
        $0.isHidden = true
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .puzzleRealWhite

        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI & Layout
    
    private func setHierarchy() {
        self.addSubview(dropdownStackView)
        dropdownStackView.addArrangedSubviews(dropdownView,
                                              dropdownTableView)
        dropdownView.addSubviews(dropdownLabel,
                                 dropdownImageView)
    }
    
    private func setLayout() {
        dropdownStackView.snp.makeConstraints {
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
