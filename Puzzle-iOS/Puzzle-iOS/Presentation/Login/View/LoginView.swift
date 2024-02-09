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
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = StringLiterals.Login.title
        $0.font = .systemFont(ofSize: 30)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    lazy var loginCollectionView = UICollectionView(frame: .zero,
                                                    collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 22
        layout.itemSize = CGSize(width: 330.0, height: 52.0)
        
        $0.collectionViewLayout = layout
        $0.isScrollEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .puzzleRealWhite
        
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI methods

    private func setHierarchy() {
        [titleLabel, loginCollectionView].forEach {
            self.addSubview($0)
        }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints() {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(429)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(39)
        } 
        
        loginCollectionView.snp.makeConstraints() {
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-19)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(22)
            $0.height.equalTo(136)
        }
    }
}
