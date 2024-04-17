//
//  AreaTableViewCell.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/19/24.
//

import UIKit

import SnapKit
import Then

final class AreaTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let areaLabel = UILabel().then {
        $0.text = StringLiterals.Onboarding.area
        $0.font = .body2
        $0.textColor = .puzzleGray800
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        contentView.addSubview(areaLabel)
    }
    
    private func setLayout() {
        areaLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(51)
        }
    }
    
    // MARK: - Method
    
    func bindData(text: String) {
        areaLabel.text = text
    }
}
