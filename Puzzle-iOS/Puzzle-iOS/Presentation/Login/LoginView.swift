//
//  LoginViewController.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/3/24.
//

import UIKit

import SnapKit
import Then

final class LoginView: UIView {
    
    private let titleLabel = UILabel()
    private let loginCollectionView = UICollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierachy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        titleLabel.do {
            $0.text = "같은 목표를 향해 함께\n달려나갈 팀원을 찾으세요."
            $0.font = .systemFont(ofSize: 30)
            $0.textColor = .black
            $0.textAlignment = .left
            $0.numberOfLines = 2
        }
        
        loginCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 22
            layout.itemSize = CGSize(width: 330.0, height: 52.0)
            
            $0.collectionViewLayout = layout
            $0.isScrollEnabled = false
        }
    }
    
    private func setHierachy() {
        [titleLabel, loginCollectionView].forEach {
            self.addSubview($0)
        }
    }
    
    private func setLayout() {
        loginCollectionView.snp.makeConstraints() {
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(19)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(22)
            $0.height.equalTo(136)
        }
        
        titleLabel.snp.makeConstraints() {
            $0.bottom.equalTo(loginCollectionView.snp.top).offset(80)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(39)
        } 
    }
}
