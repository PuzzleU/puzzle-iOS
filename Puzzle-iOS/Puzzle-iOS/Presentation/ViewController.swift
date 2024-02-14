//
//  ViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 1/25/24.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

    let dummyData = ["강아지", "토끼", "이구아나", "뱀파이어", "드래곤볼", "딱따구리딱딱딱", "돼지꿀", "고양이", "새"]
    
    private let rootView = PuzzleDropdownView(title: "지워닝")
    
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
        
        makeDropdown(mainView: rootView,
                     dropdownViewSize: CGSize(width: 150, height: 150),
                     dropdownViewLayout: .leading,
                     dropdownData: dummyData)
    }
}

