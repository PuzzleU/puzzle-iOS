//
//  PuzzleNavigationBar.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/9/24.
//

import UIKit

import SnapKit
import Then

@frozen
enum NavigationBarType {
    case leftTitle /// 좌측 타이틀만
    case centerTitle /// 중앙 타이틀만
    case leftTitleWithLeftButton /// 뒤로가기 버튼 + 좌측 타이틀
    case centerTitleWithLeftButton /// 뒤로가기 버튼 + 중앙 타이틀
}

final class PuzzleNavigationBar: UIView {
    
    //MARK: - Properties
    
    private var naviType: NavigationBarType!
    private var viewController: UIViewController?
    private var leftButtonClosure: (() -> Void)?
    
    //MARK: - UI Components
    
    private lazy var leftTitleLabel = createTitleLabel()
    private lazy var centerTitleLabel = createTitleLabel()
    
    let leftButton = UIButton().then {
        $0.setImage(UIImage(resource: .icArrow), for: .normal)
    }
    
    // MARK: - Life Cycles
    
    init(_ viewController: UIViewController, type: NavigationBarType) {
        super.init(frame: .zero)
        self.viewController = viewController
        self.setUI(type)
        self.setLayout(type)
        self.setAddTarget(type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - UI & Layout

extension PuzzleNavigationBar {
    private func setUI(_ type: NavigationBarType) {
        
        addSubviews(centerTitleLabel, leftTitleLabel, leftButton)
        
        leftButton.isHidden = (type == .leftTitle || type == .centerTitle) // Title만 있을때 버튼 제거
    }
    
    private func setLayout(_ type: NavigationBarType) {
        leftButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        switch type {
        case .leftTitle, .leftTitleWithLeftButton:
            leftTitleLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(leftButton.snp.trailing).offset(16)
                $0.leading.greaterThanOrEqualToSuperview().offset(20)
            }
        case .centerTitle, .centerTitleWithLeftButton:
            centerTitleLabel.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    }
    
    private func createTitleLabel() -> UILabel {
        return UILabel().then {
            $0.font = .pageTitle
            $0.textColor = .black
        }
    }
}

//MARK: - Custom methods

extension PuzzleNavigationBar {
    func hideNaviBar(_ isHidden: Bool) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
            [self.leftTitleLabel, self.centerTitleLabel, self.leftButton].forEach { $0.alpha = isHidden ? 0 : 1 }
        }
    }
    
    /// 내비게이션의 title을 세팅합니다.
    func setTitle(_ title: String) -> Self {
        self.leftTitleLabel.text = title
        self.centerTitleLabel.text = title
        return self
    }
    
    /// 기존 뒤로가기 버튼의 Action을 수정하고 싶을때 사용합니다.
    func resetLeftButtonAction(_ closure: (() -> Void)? = nil, _ type: NavigationBarType) -> Self {
        self.leftButtonClosure = closure
        self.leftButton.removeTarget(self, action: nil, for: .touchUpInside)
        if closure != nil {
            self.leftButton.addTarget(self, action: #selector(leftButtonDidTap), for: .touchUpInside)
        } else {
            self.setAddTarget(type)
        }
        return self
    }
    
    /// 내비게이션의 title의 font와 textColor를 수정합니다.
    func updateTitleFontAndColor(font: UIFont, color: UIColor) -> Self {
        centerTitleLabel.font = font
        centerTitleLabel.textColor = color
        return self
    }
    
    private func setAddTarget(_ type: NavigationBarType) {
        if type == .leftTitleWithLeftButton || type == .centerTitleWithLeftButton {
            leftButton.addTarget(self, action: #selector(popToPreviousVC), for: .touchUpInside)
        }
    }
}

extension PuzzleNavigationBar {
    @objc
    private func popToPreviousVC() {
        self.viewController?.popOrDismissViewController()
    }
    
    @objc
    private func leftButtonDidTap() {
        self.leftButtonClosure?()
    }
}
