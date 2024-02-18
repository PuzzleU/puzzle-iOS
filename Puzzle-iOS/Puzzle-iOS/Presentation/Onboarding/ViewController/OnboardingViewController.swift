//
//  OnboardingViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/13/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class OnboardingViewController: UIPageViewController {
    
    // MARK: - Properties
    
    private var onboardingViewModel = OnboardingTextViewModel()
    private var animalViewModel = AnimalsViewModel()
    private var positionViewModel = PositionViewModel()
    private var interestViewModel = InterestViewModel()
    private var cancelBag = CancelBag()
    
    
    // MARK: - UI Components
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    private lazy var progressBar = ProgressView(totalSteps: orderedViewControllers.count)
    
    private lazy var orderedViewControllers: [UIViewController] = {
        let signUpNameVC = OnboardingSignUpNameVC(viewModel: onboardingViewModel)
        let signUpIdVC = OnboardingSignUpIdVC(viewModel: onboardingViewModel)
        let selectProfileVC = OnboardingSelectProfileImageVC(viewModel: animalViewModel)
        let selectPositionVC = OnboardingSelectPositionVC(viewModel: positionViewModel)
        let interestVC = OnboardingInterestSelectionVC(viewModel: interestViewModel)
        return [signUpNameVC, signUpIdVC, selectProfileVC, selectPositionVC, interestVC]
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setDelegate()
        setBindings()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.addSubviews(pageViewController.view)
        view.backgroundColor = .puzzleRealWhite
    }
    
    private func setLayout() {
        if let firstViewController = orderedViewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: false, completion: nil)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        progressBar.setCurrentStep(1)
    }
    
    private func setDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
}



// MARK: - Methods

extension OnboardingViewController {
    
    private func setBindings() {
        onboardingViewModel.backButtonTapped
            .sink { [weak self] _ in
                self?.moveToPreviousPage()
            }
            .store(in: cancelBag)
        
        animalViewModel.backButtonTapped
            .sink { [weak self] _ in
                self?.moveToPreviousPage()
            }
            .store(in: cancelBag)
        
        positionViewModel.backButtonTapped
            .sink { [weak self] _ in
                self?.moveToPreviousPage()
            }
            .store(in: cancelBag)
        
        interestViewModel.backButtonTapped
            .sink { [weak self] _ in
                self?.moveToPreviousPage()
            }
            .store(in: cancelBag)
    }
    
    /// 네비게이션 바로 터치로 Page 뒤로가는 부분 구현 함수 입니다.
    private func moveToPreviousPage() {
        print("Page 뒤로 + progressBar 작동")
        
        guard let currentViewController = pageViewController.viewControllers?.first,
              let currentIndex = orderedViewControllers.firstIndex(of: currentViewController),
              currentIndex > 0 else {
            return
        }
        
        let previousViewController = orderedViewControllers[currentIndex - 1]
        pageViewController.setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)
        
        progressBar.setCurrentStep(currentIndex)
    }
}




// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController),
              viewControllerIndex - 1 >= 0 else {
            return nil
        }
        return orderedViewControllers[viewControllerIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController),
              viewControllerIndex + 1 < orderedViewControllers.count else {
            return nil
        }
        return orderedViewControllers[viewControllerIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleViewController = pageViewController.viewControllers?.first, let index = orderedViewControllers.firstIndex(of: visibleViewController) {
            progressBar.setCurrentStep(index + 1)
        }
    }
    
}
