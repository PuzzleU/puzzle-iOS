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
    
    private let loginButtonView = UIView()
    private let loginImageView = UIImageView()
    private let loginLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierachy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    
    private func setUI() {
        loginButtonView.do {
            $0.layer.cornerRadius = 15
        }
        
        loginButtonView.do {
            $0.backgroundColor = .yellow
        }
        
        loginLabel.do {
            $0.text = "로그인"
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .black
        }
    }
    
    private func setHierachy() {
        self.addSubview(loginButtonView)
        [loginLabel, loginImageView].forEach() {
            self.addSubview($0)
        }
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
    
    func bindData(_ data: LoginModel) {
        loginButtonView.backgroundColor = data.color
        loginLabel.text = data.title
        loginImageView.image = data.image
    }
}
