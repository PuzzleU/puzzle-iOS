//
//  HomeDetailHeaderView.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 4/30/24.
//

import UIKit

import SnapKit
import Then

final class HomeDetailHeaderView: UIView {
    
    // MARK: - UIComponents
    
    private let competitionImageView = UIImageView().then {
        $0.image = UIImage(resource: .testPost)
        $0.contentMode = .scaleAspectFill
        $0.isUserInteractionEnabled = true
    }
    
    lazy var homeDetailHeartButton = UIButton().then {
        $0.setImage(UIImage(resource: .icWhiteHeart), for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.backgroundColor = UIColor.puzzleBlack.cgColor
    }
    
    lazy var homeDetailReadingglassesButton = UIButton().then {
        $0.setImage(UIImage(resource: .icReadingGlasses), for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.backgroundColor = UIColor.puzzleBlack.cgColor
    }
    
    lazy var homeDetailBackButton = UIButton().then {
        $0.setImage(UIImage(resource: .icBack), for: .normal)
        $0.layer.cornerRadius = 16
        $0.layer.backgroundColor = UIColor.puzzleBlack.cgColor
    }
    
    lazy var homeDetailWebsiteButton = UIButton().then {
        $0.setTitle("홈페이지", for: .normal)
        $0.titleLabel?.font = .subTitle3
        $0.titleLabel?.textColor = .puzzleWhite
        $0.setImage(UIImage(resource: .icArrow), for: .normal)
        $0.contentHorizontalAlignment = .center
        $0.semanticContentAttribute = .forceRightToLeft
        $0.layer.cornerRadius = 16
        $0.layer.backgroundColor = UIColor.puzzleBlack.cgColor
    }
    
    lazy var homeDetailShareButton = UIButton().then {
        $0.setImage(UIImage(resource: .icShare), for: .normal)
        $0.layer.cornerRadius = 16
        $0.layer.backgroundColor = UIColor.puzzleBlack.cgColor
    }
    
    lazy var homeDetailDeleteButton = UIButton().then {
        $0.setImage(UIImage(resource: .icDelete), for: .normal)
        $0.layer.cornerRadius = 16
        $0.layer.backgroundColor = UIColor.puzzleBlack.cgColor
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .puzzleGreen
        
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        addSubviews(competitionImageView,
                   homeDetailBackButton,
                   homeDetailDeleteButton,
                   homeDetailWebsiteButton,
                   homeDetailShareButton,
                   homeDetailShareButton)
        competitionImageView.addSubviews(homeDetailHeartButton,
                                         homeDetailReadingglassesButton)
    }
    
    private func setLayout() {
        competitionImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(60)
            $0.size.equalTo(250)
            
            homeDetailHeartButton.snp.makeConstraints {
                $0.top.trailing.equalToSuperview().inset(8)
                $0.size.equalTo(40)
            }
            homeDetailReadingglassesButton.snp.makeConstraints {
                $0.bottom.trailing.equalToSuperview().inset(8)
                $0.size.equalTo(40)
            }
        }
        
        homeDetailBackButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.leading.equalToSuperview().inset(21)
            $0.size.equalTo(32)
        }
        
        homeDetailDeleteButton.snp.makeConstraints {
            $0.top.equalTo(homeDetailBackButton.snp.top)
            $0.trailing.equalToSuperview().inset(21)
            $0.size.equalTo(32)
        }
        
        homeDetailShareButton.snp.makeConstraints {
            $0.top.equalTo(homeDetailBackButton.snp.top)
            $0.trailing.equalTo(homeDetailDeleteButton.snp.leading).offset(-8)
            $0.size.equalTo(32)
        }
        
        homeDetailWebsiteButton.snp.makeConstraints {
            $0.top.equalTo(homeDetailBackButton.snp.top)
            $0.trailing.equalTo(homeDetailShareButton.snp.leading).offset(-8)
            $0.height.equalTo(32)
            $0.width.equalTo(82)
        }
    }
}
