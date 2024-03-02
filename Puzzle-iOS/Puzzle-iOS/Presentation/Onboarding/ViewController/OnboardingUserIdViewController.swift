//
//  OnboardingUserIdViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/15/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class OnboardingUserIdViewController: UIViewController {
    
    // MARK: - Properties
    
    private let idMaximumLength = 20
    private let rootView = OnboardingBaseView()
    
    private var viewModel: InputIdViewModel
    private var cancelBag = CancelBag()
    
    private let idSubject: PassthroughSubject<String, Never> = .init()
    var idPublisher: AnyPublisher<String, Never> {
        return idSubject.eraseToAnyPublisher()
    }
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        self.view.gesture(.tap())
            .map { _ in () }
            .eraseToAnyPublisher()
    }()
    
    // MARK: - UI Components
    
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("퍼즐에서 사용할 아이디를 입력해주세요")
    
    private let idTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: StringLiterals.Onboarding.inputId,
            attributes: [
                .font: UIFont.body3,
                .foregroundColor: UIColor.puzzleGray300
            ]
        )
        
        // 텍스트 필드 입력 값 스타일
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.puzzleGray300.cgColor
        $0.font = .body2
        $0.textColor = .black
        
        // "@" 레이블 생성
        let atSymbolLabel = UILabel()
        atSymbolLabel.text = "@"
        atSymbolLabel.font = .body3
        atSymbolLabel.textColor = .black
        
        // "@"를 포함할 컨테이너 뷰 생성
        let containerView = UIView()
        containerView.addSubview(atSymbolLabel)
        
        atSymbolLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(11)
            $0.trailing.equalToSuperview().offset(-11)
        }
        
        // 컨테이너 뷰의 크기를 레이블과 패딩에 맞게 조절
        let containerWidth = atSymbolLabel.intrinsicContentSize.width + 22  // 왼쪽과 오른쪽 패딩을 포함
        let containerHeight = atSymbolLabel.intrinsicContentSize.height
        containerView.frame = CGRect(x: 0, y: 0, width: containerWidth, height: containerHeight)
        
        // leftView로 컨테이너 뷰 설정
        $0.leftView = containerView
        $0.leftViewMode = .always
    }
    
    private let recommededLabel = UILabel().then {
        let label = StringLiterals.Onboarding.recommededLabel
        let specialCharacter = StringLiterals.Onboarding.recommededLabelSpecial
        
        $0.highlightSpecialText(
            mainText: label,
            specialTexts: [specialCharacter],
            mainAttributes: [
                .font: UIFont.subTitle3,
                .foregroundColor: UIColor.black
            ],
            specialAttributes: [
                .font: UIFont.subTitle3,
                .foregroundColor: UIColor.puzzlePurple
            ]
        )
    }
    
    // MARK: - Life Cycles
    
    init(viewModel: InputIdViewModel) {
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
        setNaviBind()
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        view.addSubviews(naviBar, idTextField, recommededLabel)
    }
    
    private func setLayout() {
        naviBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8 + 5)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.height.equalTo(32)
        }
        
        recommededLabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(28)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        idTextField.delegate = self
    }
    
    private func bind() {
        let input = InputIdViewModel.Input(
            idPublisher: idPublisher,
            backgroundTapPublisher: viewTapPublisher
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.buttonIsValid.sink { bool in
            self.rootView.isEnabledNextButton(isEnabled: bool)
        }.store(in: cancelBag)
    }
    
    private func observe() {
        viewTapPublisher.sink { [unowned self] _ in
            view.endEditing(true)
        }.store(in: cancelBag)
        
        idTextField.textPublisher.sink { [unowned self] text in
            idSubject.send(text)
        }.store(in: cancelBag)
        
        idPublisher.sink { str in
            print(str)
        }.store(in: cancelBag)
        
        self.rootView.nextButtonTapped.sink { [weak self] _ in
            self?.viewModel.nextButtonTapped.send()
        }.store(in: cancelBag)
    }
    
    private func setNaviBind() {
        naviBar.resetLeftButtonAction({ [weak self] in
            self?.viewModel.backButtonTapped.send()
        }, .leftTitleWithLeftButton)
    }
}

// MARK: - UITextFieldDelegate

extension OnboardingUserIdViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= idMaximumLength
    }
}
