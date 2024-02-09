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
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { [weak self] timer in
            self?.showToast(message: "입학 이전 연도는 선택하실 수 없습니다.")
        }
    }
    
}
