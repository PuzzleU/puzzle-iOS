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
    }
    
}
