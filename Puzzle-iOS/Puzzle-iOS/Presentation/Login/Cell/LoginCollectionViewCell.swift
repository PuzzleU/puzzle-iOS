//
//  LoginCollectionViewCell.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/3/24.
//

import UIKit

import SnapKit
import Then

final class LoginCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let cellIdentifier: String = "LoginCollectionViewCell"
    
    // MARK: - UI Components
    
    private let loginButtonView = UIView().then {
        $0.layer.cornerRadius = 15
    }
    
    private let loginLabel = UILabel().then {
        $0.text = StringLiterals.Login.login
        $0.font = .itemTitle
        $0.textColor = .black
    }
    
    private let loginImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    
    func bindData(_ data: LoginModel) {
        loginButtonView.backgroundColor = data.color
        loginLabel.text = data.title
        loginImageView.image = data.image
    }
    
    // MARK: - UI Methods
    
    private func setHierarchy() {
        self.addSubview(loginButtonView)
        loginButtonView.addSubviews(loginLabel, loginImageView)
    }
    
    private func setLayout() {
        loginButtonView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        loginLabel.snp.makeConstraints() {
            $0.center.equalToSuperview()
        }
        
        loginImageView.snp.makeConstraints() {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(loginLabel.snp.leading).offset(7)
            $0.size.equalTo(20)
        }
    }
}
