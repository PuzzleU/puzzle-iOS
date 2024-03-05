//
//  ResultView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/2/24.
//

import UIKit

import SnapKit
import Then

final class ResultView: UIView {
    
    // MARK: - Properties
    
    private let resultLabel = LabelFactory.build(
        text: "검색결과 \(980)건",
        font: .subTitle4,
        textColor: .puzzleGray300,
        textAlignment: .left
    )
    
    private let filterView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.layer.borderColor = UIColor.puzzleGray300.cgColor
        $0.layer.borderWidth = 1
        $0.frame = CGRect(x: 0, y: 0, width: 13, height: 7.68)
    }
    
    private let filterLabel = LabelFactory.build(
        text: "최신순",
        font: .subTitle4,
        textColor: .puzzleGray300
    )
    
    private let filterIcon = UIImageView().then {
        $0.image = UIImage(resource: .icV)
    }
    
    private lazy var hStackView = UIStackView(
        arrangedSubviews: [
            filterLabel,
            filterIcon
        ]
    ).then {
        $0.spacing = 1
        $0.axis = .horizontal
        $0.alignment = .center
    }
    
    // MARK: - UI Components
    
    init() {
        super.init(frame: .zero)
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        backgroundColor = .puzzleWhite
    }
    
    private func setHierarchy() {
        addSubviews(resultLabel, filterView)
        filterView.addSubview(hStackView)
    }
    
    private func setLayout() {
        resultLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        filterView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(19)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(24)
            $0.width.equalTo(hStackView.snp.width).offset(16)
        }
        
        hStackView.snp.makeConstraints {
            $0.top.equalTo(filterView.snp.top).offset(5)
            $0.bottom.equalTo(filterView.snp.bottom).offset(-5.56)
            $0.centerX.equalTo(filterView.snp.centerX)
            $0.leading.equalTo(filterView.snp.leading).offset(8)
        }
        
        filterIcon.snp.makeConstraints {
            $0.centerY.equalTo(hStackView.snp.centerY)
        }
    }
}
