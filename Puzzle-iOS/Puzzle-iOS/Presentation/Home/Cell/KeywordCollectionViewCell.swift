//
//  KeywordCollectionViewCell.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/2/24.
//

import UIKit

import SnapKit
import Then

final class KeywordCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.font = .body2
    }
    
    override var isSelected: Bool {
        didSet {
            toggle()
        }
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.puzzleGray400.cgColor
    }
    
    private func setHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(5.5)
            $0.bottom.equalToSuperview().offset(-5.5)
        }
    }
    
    private func toggle() {
        titleLabel.textColor = isSelected ? .puzzleWhite : .puzzleGray800
        contentView.backgroundColor = isSelected ? .puzzleGray800: .puzzleWhite
    }
    
    // MARK: - Method
    
    func bindData(with text: String) {
        titleLabel.text = text
    }
}
