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
    
    private let onboardingViewModel = OnboardingTextViewModel()
    private let animalViewModel = AnimalsViewModel()
    private let positionViewModel = PositionViewModel()
    private let interestViewModel = InterestViewModel()
    private let areaViewModel = AreaViewModel()
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
        let areaVC = OnboardingSelectAreaVC(viewModel: areaViewModel)
        return [signUpNameVC, signUpIdVC, selectProfileVC, selectPositionVC, interestVC, areaVC]
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setDelegate()
        setBindings()
    }
    
    // areaVC 에서 바텀시트를 띄울 임시 코드입니다.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let areaVC = orderedViewControllers.first(where: { $0 is OnboardingSelectAreaVC }) as? OnboardingSelectAreaVC {
            areaVC.showBottomSheetSubject
                .sink { [weak self] _ in
                    self?.showAreaBottomSheet()
                }
                .store(in: cancelBag)
        }
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
        
        areaViewModel.backButtonTapped
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
    
    // 바텀시트를 띄우는 임시 코드 입니다.
    private func showAreaBottomSheet() {
        let bottomSheetVC = PuzzleBottomSheetViewController(bottomType: .high, insertView: OnboardingPlusView())
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        present(bottomSheetVC, animated: true)
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
