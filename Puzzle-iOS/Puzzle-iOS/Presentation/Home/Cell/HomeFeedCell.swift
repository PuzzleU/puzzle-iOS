//
//  HomeFeedCell.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/3/24.
//

import UIKit

import SnapKit
import Then

// model
struct Competition {
    let image: UIImage
    let title: String
    let keywords: [String]
    let views: String
    let buildingTeams: String
    let interests: String
    let date: Int
}

enum DateStatus {
    case over30
    case between14And30
    case under14
    
    // 날짜를 기반으로 상태 결정
    init(date: Int) {
        switch date {
        case ...14: self = .under14
        case 15...30: self = .between14And30
        default: self = .over30
        }
    }
    
    // 상태에 따른 배경색 반환
    var backgroundColor: UIColor {
        switch self {
        case .over30: return .puzzleGreen
        case .between14And30: return .puzzleYello
        case .under14: return .puzzleRed
        }
    }
}

class HomeFeedCell: UICollectionViewCell {
    
    // MARK: - Property
    
    private var keywords = [String]()
    
    // MARK: - UI Components
    
    private let dateView = UIView()
    
    private let dateLabel = UILabel()
    
    private let imageView = UIImageView().then {
        $0.image = UIImage(resource: .imgbear)
    }
    
    private let titleLabel = LabelFactory.build(
        text: "제21회 KPR 대학생 PR 아이디어 공모전",
        font: .body2,
        textColor: .puzzleBlack,
        textAlignment: .left
    ).then {
        $0.numberOfLines = 2
    }
    
    private lazy var keywordHStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillEqually
        $0.alignment = .leading
    }
    
    private let views = LabelFactory.build(
        text: "",
        font: .caption2
    )
    
    private let buildingTeams = LabelFactory.build(
        text: "",
        font: .caption2
    )
    
    private let interests = LabelFactory.build(
        text: "",
        font: .caption2
    )
    
    private lazy var infoHStackView = UIStackView(
        arrangedSubviews: [
            views,
            buildingTeams,
            interests
        ]).then {
            $0.axis = .horizontal
            $0.spacing = 12
            $0.distribution = .fillEqually
    }
    
    private lazy var vStackView = UIStackView(
        arrangedSubviews: [
            imageView,
            titleLabel,
            keywordHStackView,
            infoHStackView
        ]).then {
            $0.axis = .vertical
            $0.spacing = 2
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
        backgroundColor = .white
    }
    
    private func setHierarchy() {
        addSubviews(vStackView, dateView)
        dateView.addSubview(dateLabel)
    }
    
    private func setLayout() {
        
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(148)
        }
        
        dateView.snp.makeConstraints {
            $0.top.leading.equalTo(imageView).inset(7)
        }
        
        dateLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
        
    }
    
    func setData(model: Competition) {
        self.imageView.image = model.image
        self.titleLabel.text = model.title
        self.keywords = model.keywords
        self.views.text = model.views
        self.buildingTeams.text = model.buildingTeams
        self.interests.text = model.interests
        setKeywordStackViewLayout()
        setDateLabelColor(date: model.date)
    }
    
    private func setDateLabelColor(date: Int) {
        dateLabel.do {
            $0.text = "D-\(date)"
            $0.font = .chip1
            $0.textColor = .puzzleWhite
        }
        let dateStatus = DateStatus(date: date)
        
        dateView.do {
            $0.backgroundColor = dateStatus.backgroundColor
            $0.layer.cornerRadius = 4
        }
    }
    
    // 키워드의 길이와 속성이 동적으로 작동될 때 사용하는 함수 입니다.
    private func setKeywordStackViewLayout() {
        
        keywordHStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        keywords.forEach { keyword in
            let keywordLabel = UILabel().then {
                $0.text = keyword
                $0.textAlignment = .center
                $0.textColor = .puzzleGray800
                $0.font = .caption1
            }
            
            let keywordView = UIView().then {
                $0.backgroundColor = .white
                $0.layer.cornerRadius = 8
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.puzzleGray300.cgColor
            }
            
            keywordView.addSubview(keywordLabel)
            
            keywordLabel.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 7, bottom: 2, right: 7))
            }
            
            keywordHStackView.addArrangedSubview(keywordView)
        }
    }
}
