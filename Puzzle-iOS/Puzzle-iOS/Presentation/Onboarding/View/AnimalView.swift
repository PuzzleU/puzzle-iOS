//
//  AnimalView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit

import SnapKit
import Then

class AnimalView: UIView {

    // MARK: - UI Components
    
    lazy var animalCollectionView = UICollectionView(frame: .zero,
                                                    collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        
        $0.collectionViewLayout = layout
        $0.isScrollEnabled = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .puzzleDarkGray
        
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI methods
    
    private func setHierarchy() {
        self.addSubviews(animalCollectionView)
    }
    
    private func setLayout() {
        animalCollectionView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
    }
}
