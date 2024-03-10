//
//  EmptyCell.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/10/24.
//

import UIKit

final class EmptyCell: UICollectionViewCell {
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        backgroundColor = .puzzleGray100
    }
    
}
