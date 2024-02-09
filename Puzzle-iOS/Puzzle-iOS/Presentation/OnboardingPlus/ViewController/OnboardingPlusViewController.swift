//
//  OnboardingPlusViewController.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/9/24.
//

import UIKit

final class OnboardingPlusViewController: UIViewController {

    // MARK: - Properties

    private let rootView = OnboardingPlusView()
    private lazy var naviBar = PuzzleNavigationBar(self, type: .centerTitle).setTitle("중앙 타이틀 올시다")
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(naviBar)
        // Do any additional setup after loading the view.
        naviBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
    }
    
}
