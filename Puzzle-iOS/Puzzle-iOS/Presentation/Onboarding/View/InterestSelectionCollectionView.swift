//
//  InterestSelectionCollectionView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/18/24.
//

import UIKit

import SnapKit
import Then

final class InterestSelectionCollectionView: UIView {
    
    // MARK: - UI Components
    
    lazy var mapCollectionView = UICollectionView(frame: .zero, collectionViewLayout: LeftAlignedFlowLayout()).then {
        let layout = LeftAlignedFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize // 자동 사이즈
        
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
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
        backgroundColor = .puzzleRealWhite
    }
    
    private func         setHierarchy() {
        addSubview(mapCollectionView)
    }
    
    
    private func setLayout() {
        mapCollectionView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
    }
}
