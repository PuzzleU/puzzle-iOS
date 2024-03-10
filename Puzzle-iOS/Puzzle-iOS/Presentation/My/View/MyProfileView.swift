//
//  MyProfileView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/8/24.
//

import UIKit
import SnapKit
import Then

final class MyProfileView: UIView {
    
    // MARK: - UI Components
    
    let logoView = LogoView()
    
    let profileCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        addSubviews(logoView, profileCollectionView)
    }
    
    private func setLayout() {
        logoView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        profileCollectionView.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
