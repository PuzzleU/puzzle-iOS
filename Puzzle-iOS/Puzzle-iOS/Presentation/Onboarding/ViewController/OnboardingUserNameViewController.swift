//
//  OnboardingUserNameViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/15/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class OnboardingUserNameViewController: UIViewController {
    
    // MARK: - Properties
    
    private let rootView = OnboardingBaseView()
    
    private var viewModel: InputNameViewModel
    private var cancelBag = CancelBag()
    
    private let nameSubject: PassthroughSubject<String, Never> = .init()
    
    var namePublisher: AnyPublisher<String, Never> {
        return nameSubject.eraseToAnyPublisher()
    }
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        self.view.gesture(.tap())
            .map { _ in () }
            .eraseToAnyPublisher()
    }()
    
    // MARK: - UI Components
    
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("이름을 알려주세요")
    
    private lazy var nameTextField = UITextField().then {
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
    
    init(viewModel: InputNameViewModel) {
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
        setDelegate()
        bind()
        observe()
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
    
    // MARK: - Methods
    
    private func setDelegate() {
        nameTextField.delegate = self
    }
    
    private func bind() {
        let input = InputNameViewModel.Input(
            namePublisher: namePublisher,
            backgroundTapPublisher: viewTapPublisher
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.buttonIsValid.sink { [weak self] bool in
            self?.rootView.isEnabledNextButton(isEnabled: bool)
        }.store(in: cancelBag)
    }
    
    private func observe() {
        viewTapPublisher.sink { [unowned self] _ in
            view.endEditing(true)
        }.store(in: cancelBag)
        
        nameTextField.textPublisher.sink { [unowned self] text in
            nameSubject.send(text)
        }.store(in: cancelBag)
        
        rootView.nextButtonTapped.sink { [weak self] _ in
            self?.viewModel.nextButtonTapped.send()
        }.store(in: cancelBag)
    }
}

// MARK: - UITextFieldDelegate

extension OnboardingUserNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= IntLiterals.InputValidationRule.nameMaximumLength
    }
}
