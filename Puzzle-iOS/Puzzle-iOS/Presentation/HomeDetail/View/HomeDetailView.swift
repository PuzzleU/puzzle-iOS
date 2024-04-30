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
    
    private let scrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = false
    }

    private let homeDetailHeaderView = HomeDetailHeaderView()
    private let homeDetailDescriptionView = HomeDetailDescriptionView()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .puzzleGray100
        
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        addSubview(scrollView)
        scrollView.addSubviews(homeDetailHeaderView,
                             homeDetailDescriptionView)
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide.snp.edges)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        homeDetailHeaderView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(371)
        }
        
        homeDetailDescriptionView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(homeDetailHeaderView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
}
