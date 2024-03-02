//
//  LogoView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/2/24.
//

import UIKit
import Then

class LogoView: UIView {
    
    // MARK: - Properties
    
    // MARK: - UIComponents
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(resource: .icLogo)
    }
    
    private let logoLabel = LabelFactory.build(
        text: "PUZZLE",
        font: .subTitle2,
        textColor: .puzzlePurple)
    
    private let emptyView = UIView()
    
    private let bellImageView = UIImageView().then {
        $0.image = UIImage(resource: .icBell)
    }
    
    private lazy var hStackView = UIStackView(
        arrangedSubviews: [
            logoImageView,
            logoLabel,
            emptyView,
            bellImageView
        ]
    ).then {
        $0.spacing = 4.5
    }
    
    // MARK: - Life Cycles
    
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
        addSubviews(hStackView)
    }
    
    private func setLayout() {
        hStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.width.equalTo(220)
        }
        
        bellImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
        }
        
    }
}
