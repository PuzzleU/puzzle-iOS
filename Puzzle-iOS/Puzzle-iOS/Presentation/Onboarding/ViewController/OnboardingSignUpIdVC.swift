//
//  OnboardingSignUpIdVC.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/15/24.
//

import UIKit

class OnboardingSignUpIdVC: UIViewController {
    
    // MARK: - Properties
    
    private let rootView = OnboardingBaseView()
    
    private var cancelBag = CancelBag()
    
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("ID 입력")
    
    private var viewModel: OnboardingViewModel!
    
    
    // MARK: - UI Conponents
    
    private let inputId = UITextField().then {
        $0.placeholder = "아이디를 입력해주세요"
    }
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setBindings()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        view.addSubview(naviBar)
        naviBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
    }
    
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.addSubview(inputId)
    }
    
    private func setLayout() {
        inputId.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setBindings() {
        
        viewModel = OnboardingViewModel()
        
        inputId.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.userName, on: viewModel)
            .store(in: cancelBag)
    }
    
}
