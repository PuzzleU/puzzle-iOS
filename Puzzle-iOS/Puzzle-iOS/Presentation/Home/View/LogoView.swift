//
//  LogoView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/2/24.
//

import UIKit
import Then

final class LogoView: UIView {
    
    // MARK: - Properties
    
    // MARK: - UIComponents
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(resource: .icLogo)
    }
    
    private let logoLabel = LabelFactory.build(
        text: "PUZZLE",
        font: .title2,
        textColor: .puzzlePurple)
    
    private let trailingImageView = UIImageView().then {
        $0.image = UIImage(resource: .icBell)
    }
    
    private lazy var leftStackView = UIStackView(arrangedSubviews: [logoImageView, logoLabel]).then {
        $0.spacing = 4.5
        $0.axis = .horizontal
    }
    
    private lazy var mainStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
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
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(leftStackView)
        mainStackView.addArrangedSubview(trailingImageView)
    }
    
    private func setLayout() {
        mainStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        trailingImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
        }
    }
    
    func changeTrailingImageComponent(image: UIImage) {
        trailingImageView.image = image
    }
}
