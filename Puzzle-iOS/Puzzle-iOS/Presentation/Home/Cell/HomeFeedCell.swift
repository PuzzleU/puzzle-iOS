//
//  HomeFeedCell.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/3/24.
//

import UIKit

struct Competition {
    let image: UIImage
    let title: String
    let keywords: [String]
    let views: String
    let buildingTeams: String
    let interests: String
}

class HomeFeedCell: UICollectionViewCell {
    
    
    // MARK: - Property
    
    
    // MARK: - UI Components
    
    private let imageView = UIImageView().then {
        $0.image = UIImage(resource: .imgBear)
    }
    
    private let titlaLabel = UILabel().then {
        $0.numberOfLines = 2
    }
    
    private var keyword: [String] = []
    
    private let views = UILabel().then {
        $0.text = "123"
    }
    
    private let buildingTeams = UILabel().then {
        $0.text = "123"
    }
    
    private let interests = UILabel().then {
        $0.text = "123"
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

    }
    
    private func setHierarchy() {

    }
    
    private func setLayout() {

    }
    
    func setData(model: Competition) {
        self.imageView.image = model.image
        self.titlaLabel.text = model.title
        self.keyword = model.keywords
        self.views.text = model.views
        self.buildingTeams.text = model.buildingTeams
        self.interests.text = model.interests
    }
}
