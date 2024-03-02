//
//  MainView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/2/24.
//

import UIKit

class MainView: UIView {

    init() {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setLayout() {
        backgroundColor = .chip5
    }

}
