//
//  PositionCell.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 6/3/24.
//

import UIKit

import SnapKit
import Then

final class PositionCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let titleLabel = LabelFactory.build(
        text: "",
        font: .body2,
        textAlignment: .left
    )
    
    // MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        contentView.backgroundColor = .white
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
    
    // MARK: - Method
    
    func bindData(text: String) {
        titleLabel.text = text
    }
    
    func setTitleColor(_ color: UIColor) {
        titleLabel.textColor = color
    }
}
