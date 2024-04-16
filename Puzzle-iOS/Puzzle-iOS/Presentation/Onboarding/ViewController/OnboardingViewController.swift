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
    
    private let viewModel: OnboardingViewModel
    
    private let userInfoSubject = PassthroughSubject<Void, Never>()
    var userInfoPublisher: AnyPublisher<Void, Never> {
        userInfoSubject.eraseToAnyPublisher()
    }
    
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
        
        inputUserNameVC.namePublisher
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] name in
                self?.viewModel.userName = name
                print(name)
            }
            .store(in: cancelBag)
        
        inputUserIdVC.idPublisher
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] id in
                self?.viewModel.userId = id
                print(id)
            }.store(in: cancelBag)
        
        selectProfileVC.imagePublisher
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] imageId in
                self?.viewModel.userProfile = imageId
                print(imageId)
            }.store(in: cancelBag)
        
        selectPositionVC.imageSetPublisher
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] positionImageSet in
                let result = positionImageSet.map { $0 + 1 }
                self?.viewModel.userPosition = result
                print(result)
            }.store(in: cancelBag)
        
        selectInterestVC.keywordSetPublisher
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] keywords in
                let result = keywords.map { $0 }
                self?.viewModel.userInterest = result
                print(result)
            }.store(in: cancelBag)
        
        selectAreaVC.areaSetPublisher
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] area in
                let result = area.map { $0 + 1 }
                self?.viewModel.userLocation = result
                print(result)
            }.store(in: cancelBag)
        
        return [inputUserNameVC, inputUserIdVC, selectProfileVC, selectPositionVC, selectInterestVC, selectAreaVC]
    }()
    
    // MARK: - Life Cycles
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setDelegate()
        setLayout()
        setBindings()
        setNetworkBinds()
        
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .puzzleWhite
    }
    
    private func setHierarchy() {
        view.addSubviews(
            pageViewController.view,
            progressBar
        )
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
        
        // 마지막 버튼 누르면 유저 정보 서버로 연결 이벤트 send
        areaViewModel.nextButtonTapped
            .sink { [weak self] _ in
                self?.userInfoSubject.send()
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
        
        progressBar.setCurrentStep(currentIndex + 2)
    }
}

// MARK: - UIPageViewControllerDataSource

extension OnboardingViewController: UIPageViewControllerDataSource {
    
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
}

// MARK: - UIPageViewControllerDelegate

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleViewController = pageViewController.viewControllers?.first, let index = orderedViewControllers.firstIndex(of: visibleViewController) {
            progressBar.setCurrentStep(index + 1)
        }
    }
    
}

// MARK: - Network

extension OnboardingViewController {
    private func setNetworkBinds() {
        userInfoSubject
            .sink { [weak self] _ in
                self?.sendUserInfoDataToServer()
            }
            .store(in: cancelBag)
    }
    
    private func sendUserInfoDataToServer() {
        let input = OnboardingViewModel.Input(finishedButtonTapped: userInfoPublisher)
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.userInfoSend
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀 userInfoSend finished= \(completion)")
                case .failure(let error):
                    print("🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎 userInfoSend Error =\(error)")
                    // 에러 처리 로직 추가
                }
            }, receiveValue: { [weak self] _ in
                print("‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️ userInfo Completed.")
                self?.pushToTabBarViewController()
                // TODO: 성공 화면으로 가야함 ! 지금은 TabBar로 임시 설정
            })
            .store(in: cancelBag)
    }
    
    private func pushToTabBarViewController() {
        guard let window = view.window else {
            print("현재 뷰에 윈도우 X")
            return
        }
        
        let tabBarController = PuzzleTabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
