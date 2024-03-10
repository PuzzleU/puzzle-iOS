//
//  DashedLineCollectionViewCell.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/10/24.
//

import UIKit
import SnapKit
import Then

final class DashedLineCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UIComponents
    
    private let titleLabel = LabelFactory.build(
        text: "타이틀",
        font: .body1
    )
    
    private let contentLabel = UILabel().then {
        $0.font = .body2
        $0.textColor = .puzzleGray300
        $0.textAlignment = .center
    }
    
    private let dashedView = UIView()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dashedView.addDashedBorder(
            strokeColor: .puzzleGray300,
            lineWidth: 2,
            dashPattern: [3, 3],
            cornerRadius: 16
        )
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        addSubviews(titleLabel, dashedView)
        dashedView.addSubview(contentLabel)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(14)
        }
        
        dashedView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(52)
        }
        
        contentLabel.snp.makeConstraints {
            $0.centerX.equalTo(dashedView.snp.centerX)
            $0.centerY.equalTo(dashedView.snp.centerY)
        }
    }
    
    // MARK: - Methods
    
    func bindData(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
}
