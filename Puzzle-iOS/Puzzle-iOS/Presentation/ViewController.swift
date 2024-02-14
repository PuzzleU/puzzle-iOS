//
//  ViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 1/25/24.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

    private let rootView = PuzzleDropdownView()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        self.view.addSubview(rootView)
        
        rootView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(155)
            $0.height.equalTo(40)
        }
    }
}

