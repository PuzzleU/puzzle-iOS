//
//  OnboardingCollectionViewCell.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let imageView = UIImageView()
    
    private let checkBackgroundView = UIView().then {
        $0.backgroundColor = .puzzlePurple
        $0.isHidden = true
    }
    
    private let checkIcon = UIImageView().then {
        $0.image = UIImage(resource: .icCheck)
    }
    
    private let borderView = UIView().then {
        $0.layer.borderWidth = 3.0
        $0.layer.borderColor = UIColor.puzzlePurple.cgColor
        $0.layer.cornerRadius = 10
        $0.isHidden = true
    }
    
    override var isSelected: Bool {
        didSet {
            updateLayer()
        }
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkBackgroundView.layer.cornerRadius = checkBackgroundView.bounds.height / 2
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        backgroundColor = .puzzleGray100
        layer.cornerRadius = 10
    }
    
    private func setHierarchy() {
        addSubviews(
            imageView,
            borderView,
            checkBackgroundView
        )
        checkBackgroundView.addSubview(checkIcon)
    }
    
    private func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        borderView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        checkBackgroundView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.leading.equalTo(imageView.snp.leading).offset(-6)
            $0.top.equalTo(imageView.snp.top).offset(-6)
        }
        
        checkIcon.snp.makeConstraints {
            $0.centerX.equalTo(checkBackgroundView)
            $0.centerY.equalTo(checkBackgroundView)
        }
    }
    
    // MARK: - Custom Methods
    
    func bindData(image: UIImage) {
        imageView.image = image
    }
    
    private func updateLayer() {
        checkBackgroundView.isHidden = !isSelected
        borderView.isHidden = !isSelected
    }
}
