//
//  SplashViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/28/24.
//

import UIKit
import Combine

final class SplashViewController: UIViewController {
    
    // MARK: - Property
    
    private var cancelBag = CancelBag()
    
    //    private let onboardingDataRepository = DefaultSplashRepository(splashService: <#T##SplashService#>)
    
    // MARK: - UIComponents
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        checkDidSignIn()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .puzzleGreen
    }
    
    // MARK: - Methods
    
    // 이미 회원가입이 되어 있는 경우
    private func pushToTabBarViewController() {
        let tabBarController = PuzzleTabBarController()
        guard let window = self.view.window else { return }
        ViewControllerUtils.setRootViewController(window: window, viewController: tabBarController, withAnimation: true)
    }
    
    // 온보딩 해야되는 경우
    private func pushToOnboardingViewController() {
        let onboardingController = OnboardingViewController(viewModel: OnboardingViewModel())
        guard let window = self.view.window else { return }
        ViewControllerUtils.setRootViewController(window: window, viewController: onboardingController, withAnimation: true)
    }
}

extension SplashViewController {
    // TODO: 여기서 회원 가입했는지 안했는지 로직 구현 해야 합니다.
    private func checkDidSignIn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.pushToOnboardingViewController()
        }
    }
}
