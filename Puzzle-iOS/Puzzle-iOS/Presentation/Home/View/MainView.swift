//
//  MainView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/2/24.
//

import UIKit

import SnapKit
import Then

class MainView: UIView {
    
    // MARK: - Property
    var feedList: [Competition] = [Competition(
        image: UIImage(resource: .imgOx),
        title: "제 21회KPR 대학생 PR 아이디어 공모전",
        keywords: ["마케팅", "미디어", "기획"],
        views: "1800",
        buildingTeams: "6",
        interests: "106"
    )]
    
    // MARK: - UI Components
    
    lazy var mainFeedCollectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 10, height: 10)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
    }
    
    // MARK: - Life Cycles
    
    init() {
        super.init(frame: .zero)
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        register()
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
        backgroundColor = .chip5
    }
    
    private func setDelegate() {
        mainFeedCollectionView.dataSource = self
    }
    
    private func register() {
        mainFeedCollectionView.register(HomeFeedCell.self, forCellWithReuseIdentifier: HomeFeedCell.className)
    }
    
}

extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFeedCell.className, for: indexPath) as? HomeFeedCell else {
            return UICollectionViewCell()
        }
        
        let model = self.feedList[indexPath.item]
        cell.setData(model: model)
        return cell
    }
}
