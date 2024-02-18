//
//  InterestSelectionViewCell.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit

import SnapKit
import Then

class InterestSelectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .body2
    }

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
        contentView.addSubview(titleLabel)
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.puzzleDarkGray.cgColor
    }

    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(5.5)
            $0.bottom.equalToSuperview().offset(-5.5)
        }
    }
    // MARK: - Method
    
    func bindData(with text: String) {
        titleLabel.text = text
    }
}
