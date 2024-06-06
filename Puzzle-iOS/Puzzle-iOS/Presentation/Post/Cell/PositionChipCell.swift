//
//  PositionChips.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 6/4/24.
//

import UIKit

import SnapKit
import Then

final class PositionChipCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let titleLabel = LabelFactory.build(
        text: "개발",
        font: .body2,
        textColor: .white,
        textAlignment: .left
    )
    
    private let ImageX = UIImageView().then {
        $0.image = UIImage(resource: .icX)
    }
    
    private let keywordView = UIView().then {
        $0.backgroundColor = .puzzleGray800
        $0.layer.cornerRadius = 4
    }
    
    private lazy var HStackView = UIStackView(
        arrangedSubviews: [
            titleLabel,
            ImageX
        ]
    ).then {
        $0.axis = .horizontal
        $0.alignment = .fill
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
        contentView.backgroundColor = .white
    }
    
    private func setHierarchy() {
        contentView.addSubview(keywordView)
        keywordView.addSubview(HStackView)
    }
    
    private func setLayout() {
        
        keywordView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        HStackView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(keywordView)
        }
    }
    
    func selfKeyword() -> String {
        return self.titleLabel.text ?? "없는 키워드"
    }
    
    // MARK: - Method
    
    func bindData(text: String) {
        titleLabel.text = text
    }
}
