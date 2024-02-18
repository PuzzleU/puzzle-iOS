//
//  InterestSelectionHeaderView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/18/24.
//

import UIKit

import SnapKit
import Then

class InterestSelectionHeaderView: UICollectionReusableView {

    // MARK: - UI Components

    private let titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = .body1
        $0.textColor = .black
    }

    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setLayout() {
        addSubview(titleLabel)
        
        backgroundColor = .clear
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func bindData(with title: String) {
        titleLabel.text = title
    }
}

