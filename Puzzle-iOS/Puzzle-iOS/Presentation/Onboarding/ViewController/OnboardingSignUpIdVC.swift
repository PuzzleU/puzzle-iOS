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
    
    private var viewModel: OnboardingViewModel
    
    
    // MARK: - UI Conponents
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("퍼즐에서 사용할 아이디를 입력해주세요")
    
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
        
        $0.font = .body2
        $0.textColor = .black
        
        $0.addLeftPadding(width: 11)
    }
    
    // MARK: - Life Cycles
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setBindings()
        setupNaviBindings()
    }
    
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.addSubviews(naviBar, inputId)
    }
    private func setLayout() {
        
        naviBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8 + 5)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        inputId.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.height.equalTo(32)
        }
    }
    
    private func setBindings() {
        
        inputId.textPublisher
            .print()
            .receive(on: DispatchQueue.main)
            .assign(to: \.userId, on: viewModel)
            .store(in: cancelBag)
    }
    
}


// MARK: - Methods

extension OnboardingSignUpIdVC {
    private func setupNaviBindings() {
        naviBar.resetLeftButtonAction({ [weak self] in
            print("네비 뒤로")
            self?.viewModel.backButtonTapped.send()
        }, .leftTitleWithLeftButton)
    }
}
