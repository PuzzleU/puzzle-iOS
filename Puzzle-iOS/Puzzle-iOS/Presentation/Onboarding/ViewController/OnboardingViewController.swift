//
//  OnboardingViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/13/24.
//

import UIKit
import Combine

import Then
import SnapKit

final class OnboardingViewController: UIPageViewController {
    
    // MARK: - Properties
    
    private var viewModel = OnboardingViewModel()
    
    private var cancelBag = CancelBag()
    
    private lazy var progressBar = ProgressView(totalSteps: orderedViewControllers.count)
    
    lazy var orderedViewControllers: [UIViewController] = {
        let signUpNameVC = OnboardingSignUpNameVC(viewModel: viewModel)
        let signUpIdVC = OnboardingSignUpIdVC(viewModel: viewModel)
        let VC = ViewController()
        return [signUpNameVC, signUpIdVC, VC]
    }()
    
    
    
    // MARK: - UI Conponents
    
    // MARK: - Life Cycles
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        
        view.addSubviews(pageViewController.view)
        view.backgroundColor = .puzzleRealWhite
        addChild(pageViewController)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: false, completion: nil)
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(8)
        }
        
        progressBar.setCurrentStep(1)
        
    }
    
}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = orderedViewControllers.firstIndex(of: first) else { return 0}
        return index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleViewController = pageViewController.viewControllers?.first, let index = orderedViewControllers.firstIndex(of: visibleViewController) {
            progressBar.setCurrentStep(index + 1)
        }
    }
    
}

extension OnboardingViewController {
    
    private func setupBindings() {
        viewModel.backButtonTapped
            .print()
            .sink { [weak self] _ in
                print("여긴오나?")
                self?.moveToPreviousPage()
            }
            .store(in: cancelBag)
    }
    
    private func moveToPreviousPage() {
        print("이게되네 ...")
        
        guard let currentViewController = pageViewController.viewControllers?.first,
              let currentIndex = orderedViewControllers.firstIndex(of: currentViewController),
              currentIndex > 0 else {
            return
        }
        
        let previousViewController = orderedViewControllers[currentIndex - 1]
        pageViewController.setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)
    }
}

