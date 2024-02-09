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
enum NaviType {
    case leftTitle /// 좌측 타이틀만
    case centerTitle /// 중앙 타이틀만
    case leftTitleWithLeftButton /// 뒤로가기 버튼 + 좌측 타이틀
    case centerTitleWithLeftButton /// 뒤로가기 버튼 + 중앙 타이틀
}

final class PuzzleNavigationBar: UIView {
    
    // MARK: - Properties
    
    private var naviType: NaviType!
    private var vc: UIViewController?
    private var leftButtonClosure: (() -> Void)?
    
    // MARK: - UI Components
    
    private let leftTitleLabel = UILabel()
    private let centerTitleLabel = UILabel()
    let leftButton = UIButton()
    
    // MARK: - initialization
    
    init(_ vc: UIViewController, type: NaviType) {
        super.init(frame: .zero)
        self.vc = vc
        self.setUI(type)
        self.setLayout(type)
        self.setAddTarget(type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Methods

extension PuzzleNavigationBar {
    func hideNaviBar(_ isHidden: Bool) {
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveEaseInOut) {
            [self.leftTitleLabel, self.centerTitleLabel, self.leftButton].forEach { $0.alpha = isHidden ? 0 : 1 }
        }
    }
    
    @discardableResult
    func setTitle(_ title: String) -> Self {
        self.leftTitleLabel.text = title
        self.centerTitleLabel.text = title
        return self
    }
    
    @discardableResult
    func resetLeftButtonAction(_ closure: (() -> Void)? = nil, _ type: NaviType) -> Self {
        self.leftButtonClosure = closure
        self.leftButton.removeTarget(self, action: nil, for: .touchUpInside)
        if closure != nil {
            self.leftButton.addTarget(self, action: #selector(leftButtonDidTap), for: .touchUpInside)
        } else {
            self.setAddTarget(type)
        }
        return self
    }
    
    @discardableResult
    func changeTitleWithLeftButton(_ font: UIFont, _ color: UIColor) -> Self {
        centerTitleLabel.font = font
        centerTitleLabel.textColor = color
        return self
    }
    
    private func setAddTarget(_ type: NaviType) {
        self.naviType = type
        self.leftButton.addTarget(self, action: #selector(popToPreviousVC), for: .touchUpInside)
        
    }
}

// MARK: - @objc Function

extension PuzzleNavigationBar {
    @objc
    private func popToPreviousVC() {
        guard let vc = vc else { return }
        self.vc?.navigationController?.popViewController(animated: true)
        if vc.presentingViewController != nil {
            self.vc?.dismiss(animated: true)
            
        }
    }
    
    @objc
    private func leftButtonDidTap() {
        self.leftButtonClosure?()
    }
}

// MARK: - UI & Layout

extension PuzzleNavigationBar {
    private func setUI(_ type: NaviType) {
        self.naviType = type
        self.backgroundColor = .puzzleWhite
        
        switch type {
        case .leftTitle:
            leftTitleLabel.font = .systemFont(ofSize: 18)
            leftTitleLabel.textColor = .black
        case .centerTitle:
            centerTitleLabel.font = .systemFont(ofSize: 18)
            centerTitleLabel.textColor = .black
        case .leftTitleWithLeftButton:
            leftTitleLabel.text = ""
            leftTitleLabel.font = .systemFont(ofSize: 18)
            leftTitleLabel.textColor = .black
            leftButton.setImage(UIImage(resource: .icArrow), for: .normal)
        case .centerTitleWithLeftButton:
            centerTitleLabel.text = ""
            centerTitleLabel.font = .systemFont(ofSize: 18)
            centerTitleLabel.textColor = .black
            leftButton.setImage(UIImage(resource: .icArrow), for: .normal)
        }
    }
    
    private func setCenterTitleWithLeftButton() {
        centerTitleLabel.text = ""
        centerTitleLabel.font = .systemFont(ofSize: 18)
        centerTitleLabel.textColor = .black
        centerTitleLabel.isHidden = false
        leftButton.isHidden = false
        leftButton.setImage(UIImage(resource: .icArrow), for: .normal)
    }
    
    private func setLayout(_ type: NaviType) {
        switch type {
        case .leftTitle:
            setLeftTitleLayout()
        case .centerTitle:
            setCenterTitleLayout()
        case .leftTitleWithLeftButton:
            setLeftTitleWithLeftButtonLayout()
        case .centerTitleWithLeftButton:
            setCenterTitleWithLeftButtonLayout()
        }
    }
    
    private func setLeftTitleLayout() {
        self.addSubview(leftTitleLabel)
        
        leftTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
    }
    
    private func setCenterTitleLayout() {
        self.addSubview(centerTitleLabel)
        
        centerTitleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setLeftTitleWithLeftButtonLayout() {
        self.addSubviews(leftButton, leftTitleLabel)
        
        leftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        leftTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(leftButton.snp.trailing).offset(16)
        }
    }
    
    private func setCenterTitleWithLeftButtonLayout() {
        self.addSubviews(leftButton, centerTitleLabel)
        
        leftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        centerTitleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
