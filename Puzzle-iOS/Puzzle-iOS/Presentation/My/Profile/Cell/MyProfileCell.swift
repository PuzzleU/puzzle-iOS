//
//  MyProfileCell.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/10/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class MyProfileCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var cancelBag = CancelBag()
    
    // MARK: - UIComponents
    
    private let profileBackgroundView = UIImageView(image: UIImage(resource: .imgMyBackground))
    
    private let contatinerView = UIView().then {
        $0.backgroundColor = .puzzleWhite
        $0.layer.cornerRadius = 20
    }
    
    private let profileImageView = UIImageView(image: UIImage(resource: .imgFox)).then {
        $0.clipsToBounds = true
    }
    
    private let introduceBackgroundView = UIView().then {
        $0.backgroundColor = .puzzleWhite
    }
    
    private lazy var vBackgroundStackView = UIStackView(
        arrangedSubviews: [
            profileBackgroundView,
            introduceBackgroundView
        ]
    ).then {
        $0.axis = .vertical
    }
    
    private let titleName = LabelFactory.build(
        text: "이명진",
        font: .title2
    )
    
    private let keyword1 = KeywordFactory.build(
        text: "기획",
        font: .chip1,
        backgroundColor: .chip1
    )
    
    private let keyword2 = KeywordFactory.build(
        text: "개발",
        font: .chip1,
        backgroundColor: .chip5
    )
    
    private let editButton = UIButton(type: .custom).then {
        $0.setImage(.icEdit, for: .normal)
    }
    
    private let userId = LabelFactory.build(
        text: "@th1ngjin",
        font: .body2
    )
    
    private let userPersonalType = TypeIconFactory.build(
        text: "D 타입",
        font: .subTitle4,
        textColor: .puzzleGreen,
        borderColor: UIColor.puzzleGreen.cgColor
    )
    
    private let userSimpleintroduceLabel = LabelFactory.build(
        text: "안녕하세요 이명진 입니다. 잘 부탁 드립니다 용가리 링딩동 링딩동 디기디기",
        font: .body2,
        textAlignment: .left
    ).then {
        $0.numberOfLines = 2
    }
    
    private lazy var titleHStackView = UIStackView(
        arrangedSubviews: [
            titleName,
            keyword1,
            keyword2,
            editButton
        ]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 11
    }
    
    private lazy var infoVStackView = UIStackView(
        arrangedSubviews: [
            titleHStackView,
            userId,
            userPersonalType,
            userSimpleintroduceLabel
        ]
    ).then {
        $0.axis = .vertical
        $0.spacing = 7
        $0.alignment = .leading
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
    }
    
    private func setHierarchy() {
        addSubviews(
            vBackgroundStackView,
            contatinerView,
            profileImageView,
            infoVStackView
        )
    }
    
    private func setLayout() {
        
        vBackgroundStackView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        profileBackgroundView.snp.makeConstraints {
            $0.height.equalTo(123)
        }
        
        contatinerView.snp.makeConstraints {
            $0.width.height.equalTo(120)
            $0.top.equalTo(vBackgroundStackView.snp.top).offset(63)
            $0.leading.equalToSuperview().inset(27)
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerX.equalTo(contatinerView.snp.centerX)
            $0.centerY.equalTo(contatinerView.snp.centerY)
            $0.width.height.equalTo(contatinerView.snp.width).multipliedBy(0.8)
        }
        
        infoVStackView.snp.makeConstraints {
            $0.top.equalTo(profileBackgroundView.snp.bottom).offset(72)
            $0.leading.equalToSuperview().inset(22)
            $0.trailing.equalToSuperview().inset(32)
        }
        
        updateProfileImageUI()
    }
    
    private func updateProfileImageUI() {
        self.layoutIfNeeded()
        
        contatinerView.layer.cornerRadius = contatinerView.bounds.width / 2
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
    }
}
