//
//  SettingCell.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/15/24.
//

import UIKit

import SnapKit
import Then

final class SettingCell: UICollectionViewCell {
    
    private let titleLabel = LabelFactory.build(
        text: "타이틀",
        font: .body2
    )
    
    private let arrowImage = UIImageView().then {
        $0.image = UIImage(resource: .icRightArrow)
    }
    
    private lazy var hStackView = UIStackView(
        arrangedSubviews: [
            titleLabel,
            arrowImage
        ]
    ).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    
    // MARK: - Life Cycle
    
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
        backgroundColor = .puzzleWhite
        
        arrowImage.do {
            $0.tintColor = .puzzleGray800
        }
    }
    
    private func setHierarchy() {
        contentView.addSubview(hStackView)
    }
    
    private func setLayout() {
        hStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func dataBind(title: String) {
        titleLabel.text = title
    }
}
