//
//  OnboardingUserNameViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/15/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingUserNameViewController: UIViewController {
    
    // MARK: - Properties
    
    private let rootView = OnboardingBaseView()
    
    private var viewModel: OnboardingTextViewModel
    private var cancelBag = CancelBag()
    
    // MARK: - UI Components
    
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("이름을 알려주세요")
    
    private let nameTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: StringLiterals.Onboarding.inputName,
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
    
    init(viewModel: OnboardingTextViewModel) {
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
        setHierarchy()
        setLayout()
        setBindings()
    }
    
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        view.addSubviews(naviBar, nameTextField)
    }
    
    private func setLayout() {
        naviBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8 + 5)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.height.equalTo(32)
        }
    }
    
    private func setBindings() {
        nameTextField.textPublisher
            .print()
            .receive(on: DispatchQueue.main)
            .assign(to: \.userName, on: viewModel)
            .store(in: cancelBag)
    }
}
