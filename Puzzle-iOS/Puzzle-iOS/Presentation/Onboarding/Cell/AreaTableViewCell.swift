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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(51)
        }
    }
    
    // MARK: - Method
    
    func bindData(with text: String) {
        areaLabel.text = text
    }
}
