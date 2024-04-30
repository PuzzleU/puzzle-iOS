//
//  HomeDetailView.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 4/30/24.
//

import UIKit
import Combine

final class HomeDetailView: UIView {
    
    // MARK: - Properties

    
    // MARK: - UIComponents
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .puzzleWhite
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        backgroundColor = .puzzleWhite
    }
    
    private func setHierarchy() {
        
    }
    
    private func setLayout() {

    }
}
