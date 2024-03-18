//
//  MainView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/2/24.
//

import UIKit

import SnapKit
import Then

final class MainView: UIView {
    
    // MARK: - Property
    
    // 삭제될 객체 입니다. 또는 ViewModel에서 받을 데이터 입니다.
    var feedList: [Competition] = [Competition(
        image: UIImage(resource: .imgOx),
        title: "제 21회KPR 대학생 PR 아이디어 공모전",
        keywords: ["마케팅", "미디어", "기획"],
        views: "조회 1800",
        buildingTeams: "빌딩중인 팀 6",
        interests: "스크랩 106",
        date: 40
    ), Competition(
        image: UIImage(resource: .imgDog),
        title: "제 21회KPR 대학생 PR 아이디어 공모전",
        keywords: ["iOS", "안드로이드"],
        views: "조회 1800",
        buildingTeams: "빌딩중인 팀 6",
        interests: "스크랩 106",
        date: 20
    ), Competition(
        image: UIImage(resource: .imgData),
        title: "제 21회KPR 대학생 PR 아이디어 공모전",
        keywords: ["마케팅", "미디어", "기획"],
        views: "조회 1800",
        buildingTeams: "빌딩중인 팀 6",
        interests: "스크랩 106",
        date: 12
    ), Competition(
        image: UIImage(resource: .imgLion),
        title: "제 21회KPR 대학생 PR 아이디어 공모전",
        keywords: ["마케팅", "미디어", "기획"],
        views: "조회 1800",
        buildingTeams: "빌딩중인 팀 6",
        interests: "스크랩 106",
        date: 1
    ), Competition(
        image: UIImage(resource: .imgOx),
        title: "제 21회KPR 대학생 PR 아이디어 공모전",
        keywords: ["마케팅", "미디어", "기획"],
        views: "조회 1800",
        buildingTeams: "빌딩중인 팀 6",
        interests: "스크랩 106",
        date: 30
    ), Competition(
        image: UIImage(resource: .imgOx),
        title: "제 21회KPR 대학생 PR 아이디어 공모전",
        keywords: ["마케팅", "미디어", "기획"],
        views: "조회 1800",
        buildingTeams: "빌딩중인 팀 6",
        interests: "스크랩 106",
        date: 100
    ), Competition(
        image: UIImage(resource: .imgOx),
        title: "제 21회KPR 대학생 PR 아이디어 공모전",
        keywords: ["마케팅", "미디어", "기획"],
        views: "조회 1800",
        buildingTeams: "빌딩중인 팀 6",
        interests: "스크랩 106",
        date: 57
    )]
    
    // MARK: - UI Components
    
    lazy var mainFeedCollectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        
        layout.sectionInset = UIEdgeInsets(top: 9, left: 20, bottom: 9, right: 20)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 11
        
        let totalSpacing = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing
        let cellWidth = (screenWidth - totalSpacing) / 2
        let cellHeight = cellWidth * (219 / 161)
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
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
        backgroundColor = .white
    }
    
    private func setHierarchy() {
        addSubview(mainFeedCollectionView)
    }
    
    private func setLayout() {
        mainFeedCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        mainFeedCollectionView.dataSource = self
    }
    
    private func register() {
        mainFeedCollectionView.register(HomeFeedCell.self, forCellWithReuseIdentifier: HomeFeedCell.className)
    }
    
}

// MARK: - UICollectionViewDataSource

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
