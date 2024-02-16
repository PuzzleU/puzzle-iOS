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
        $0.attributedPlaceholder = NSAttributedString(
            string: "이름을 입력해주세요!",
            attributes: [
                .font: UIFont.body3,
                .foregroundColor: UIColor.puzzleLightGray
            ]
        )
        
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.puzzleLightGray.cgColor
        
        $0.font = .body3
        $0.textColor = .black
        
        $0.addLeftPadding(width: 11)
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
    
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.addSubviews(naviBar, inputId)
    }
    private func setLayout() {
        
        naviBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        inputId.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.height.equalTo(32)
        }
    }
    
    private func setBindings() {
        
        viewModel = OnboardingViewModel()
        
        inputId.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.userId, on: viewModel)
            .store(in: cancelBag)
    }
    
}
