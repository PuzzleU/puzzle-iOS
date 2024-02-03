//
//  LoginViewController.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/3/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class LoginViewController: UIViewController {

    private let rootView = LoginView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        register()
        delegate()
    }
    
    private func register() {
        rootView.loginCollectionView.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: LoginCollectionViewCell.cellIdentifier)
    }
    
    private func delegate() {
        rootView.loginCollectionView.delegate = self
        rootView.loginCollectionView.dataSource = self
    }

}

extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginCollectionViewCell.cellIdentifier, for: indexPath) as? LoginCollectionViewCell
        else { return UICollectionViewCell()}
        
        cell.bindData(LoginButtonData[indexPath.row])
        
        return cell
    }
}
