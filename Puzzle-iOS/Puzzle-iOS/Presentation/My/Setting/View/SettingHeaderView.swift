//
//  SettingHeaderView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/18/24.
//

import UIKit

import SnapKit
import Then

class SettingHeaderView: UICollectionReusableView {
    
    // MARK: - UIComponents
    
    private let titleLabel = UILabel().then {
        $0.font = .body1
        $0.textColor = .puzzleGray300
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        addSubview(titleLabel)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(25)
        }
    }
    
    // MARK: - Methods
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
