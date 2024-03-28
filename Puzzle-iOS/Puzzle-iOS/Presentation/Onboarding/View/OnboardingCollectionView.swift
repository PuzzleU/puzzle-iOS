//
//  OnboardingCollectionView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingCollectionView: UIView {
    
    // MARK: - Property
    
    final let itemSize = CGSize(width: 100, height: 100)
    final let inset: UIEdgeInsets = UIEdgeInsets(top: 6, left: 8, bottom: 0, right: 8)
    final let lineSpacing: CGFloat = 8
    final let interItemSpacing: CGFloat = 8
    
    // MARK: - UI Components
    
    lazy var onboardingCollectionView = UICollectionView(frame: .zero,
                                                         collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.sectionInset = inset
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interItemSpacing
        
        $0.collectionViewLayout = layout
        $0.isScrollEnabled = false
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
        self.backgroundColor = .clear
    }
    
    private func setHierarchy() {
        self.addSubview(onboardingCollectionView)
    }
    
    private func setLayout() {
        onboardingCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
