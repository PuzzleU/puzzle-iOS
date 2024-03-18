//
//  SettingView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/15/24.
//

import UIKit

import SnapKit
import Then

final class SettingView: UIView {
    
    // MARK: - UIComponents
    
    let settingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .puzzleWhite
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
        addSubview(settingCollectionView)
    }
    
    private func setLayout() {
        settingCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
