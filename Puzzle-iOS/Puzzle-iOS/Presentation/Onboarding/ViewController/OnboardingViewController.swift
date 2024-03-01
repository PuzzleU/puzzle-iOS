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

final class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    private let inputNameViewModel = InputNameViewModel()
    private let inputIdViewModel = InputIdViewModel()
    private let animalViewModel = ProfileViewModel()
    private let positionViewModel = PositionViewModel()
    private let interestViewModel = InterestViewModel()
    private let areaViewModel = AreaViewModel()
    private var cancelBag = CancelBag()
    
    // MARK: - UI Components
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    private lazy var progressBar = ProgressView(totalSteps: orderedViewControllers.count)
    
    private lazy var orderedViewControllers: [UIViewController] = {
        let inputUserNameVC = OnboardingUserNameViewController(viewModel: inputNameViewModel)
        let inputUserIdVC = OnboardingUserIdViewController(viewModel: inputIdViewModel)
        let selectProfileVC = OnboardingSelectProfileImageViewController(viewModel: animalViewModel)
        let selectPositionVC = OnboardingSelectPositionViewController(viewModel: positionViewModel)
        let selectInterestVC = OnboardingSelectInterestViewController(viewModel: interestViewModel)
        let selectAreaVC = OnboardingSelectAreaViewController(viewModel: areaViewModel)
        return [inputUserNameVC, inputUserIdVC, selectProfileVC, selectPositionVC, selectInterestVC, selectAreaVC]
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setDelegate()
        setLayout()
        setBindings()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .puzzleRealWhite
    }
    
    private func setHierarchy() {
        view.addSubviews(pageViewController.view, progressBar)
    }
    
    private func setLayout() {
        if let firstViewController = orderedViewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: false, completion: nil)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
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
        inputIdViewModel.backButtonTapped
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
        
        areaViewModel.backButtonTapped
            .sink { [weak self] _ in
                self?.moveToPreviousPage()
            }
            .store(in: cancelBag)
        
        inputNameViewModel.nextButtonTapped
            .sink { [weak self] _ in
                self?.moveToNextPage()
            }
            .store(in: cancelBag)
        
        inputIdViewModel.nextButtonTapped
            .sink { [weak self] _ in
                self?.moveToNextPage()
            }
            .store(in: cancelBag)
        
        animalViewModel.nextButtonTapped
            .sink { [weak self] _ in
                self?.moveToNextPage()
            }
            .store(in: cancelBag)
        
        positionViewModel.nextButtonTapped
            .sink { [weak self] _ in
                self?.moveToNextPage()
            }
            .store(in: cancelBag)
        
        interestViewModel.nextButtonTapped
            .sink { [weak self] _ in
                self?.moveToNextPage()
            }
            .store(in: cancelBag)
        
        areaViewModel.nextButtonTapped
            .sink { [weak self] _ in
                self?.moveToNextPage()
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
        
        print(currentIndex)
        
        let previousViewController = orderedViewControllers[currentIndex - 1]
        pageViewController.setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)
        
        progressBar.setCurrentStep(currentIndex)
    }
    
    private func moveToNextPage() {
        print("Page 앞으로 + progressBar 작동")
        
        guard let currentViewController = pageViewController.viewControllers?.first,
              let currentIndex = orderedViewControllers.firstIndex(of: currentViewController),
              currentIndex + 1 < orderedViewControllers.count else {
            return
        }
        
        let nextViewController = orderedViewControllers[currentIndex + 1]
        
        pageViewController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        
        progressBar.setCurrentStep(currentIndex + 1)
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
