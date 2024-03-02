//
//  PuzzleDropDownTableViewCell.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/14/24.
//

import UIKit

import SnapKit
import Then

final class PuzzleDropDownTableViewCell: UITableViewCell {

    // MARK: - UI Components
    
    private let cellLabel = UILabel().then {
        $0.font = .body3
        $0.textColor = .puzzleBlack
    }
    
    private let divderView = UIView().then {
        $0.backgroundColor = .puzzleGray300
    }
    
    // MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI & Layout

    private func setHierarchy() {
        self.addSubviews(divderView,
                         cellLabel)
    }
    
    private func setLayout() {
        divderView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.height.equalTo(0.3)
        }
        
        cellLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(27)
        }
    }
    
    //MARK: - Data
    
    func bindText(text: String) {
        cellLabel.text = text
    }
}
