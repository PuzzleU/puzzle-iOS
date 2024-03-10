//
//  AreaUITableView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/19/24.
//

import UIKit

import SnapKit
import Then

final class AreaTableView: UIView {
    
    private let areaTableView = UITableView().then {
        $0.backgroundColor = .puzzleWhite
    }
    
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
        backgroundColor = .puzzleWhite
    }
    
    private func setHierarchy() {
        addSubview(areaTableView)
    }
    
    private func setLayout() {
        areaTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
