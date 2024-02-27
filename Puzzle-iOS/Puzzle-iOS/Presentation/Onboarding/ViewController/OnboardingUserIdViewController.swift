//
//  OnboardingUserIdViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/15/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingUserIdViewController: UIViewController {
    
    // MARK: - Properties
    
    private let rootView = OnboardingBaseView()
    
    private var viewModel: InputNameViewModel
    private var cancelBag = CancelBag()
    
    // MARK: - UI Components
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("퍼즐에서 사용할 아이디를 입력해주세요")
    
    private let idTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: StringLiterals.Onboarding.inputId,
            attributes: [
                .font: UIFont.body3,
                .foregroundColor: UIColor.puzzleLightGray
            ]
        )
        
        // 텍스트 필드 입력 값 스타일
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.puzzleLightGray.cgColor
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
        setupNaviBindings()
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
}

// MARK: - Methods

extension OnboardingUserIdViewController {
    private func setupNaviBindings() {
        naviBar.resetLeftButtonAction({ [weak self] in
            self?.viewModel.backButtonTapped.send()
        }, .leftTitleWithLeftButton)
    }
}
