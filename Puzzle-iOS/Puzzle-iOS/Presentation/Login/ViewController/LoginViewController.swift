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
    
    // MARK: - Properties
    
    private var cancelBag = CancelBag()
    private let viewModel: LoginViewModel
    private let rootView = LoginView()
    private lazy var kakaoLoginPublisher = PassthroughSubject<Void, Never>()
    private lazy var appleLoginPublisher = PassthroughSubject<Void, Never>()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        delegate()
        bindViewModel()
    }
    
    // MARK: - Custom Methods
    
    private func register() {
        rootView.loginCollectionView.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: LoginCollectionViewCell.cellIdentifier)
    }
    
    private func delegate() {
        rootView.loginCollectionView.delegate = self
        rootView.loginCollectionView.dataSource = self
    }
    
    private func bindViewModel() {
        let input = LoginViewModel.Input(
            kakaoTapped: kakaoLoginPublisher.eraseToAnyPublisher(),
            appleTapped: appleLoginPublisher.eraseToAnyPublisher()
        )
        
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
        
        output.userInfoPublisher
            .receive(on: RunLoop.main)
            .sink { value in
                print(value)
            }
            .store(in: self.cancelBag)
    }
}

// MARK: - UICollectionView Extension

extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LoginButtonData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginCollectionViewCell.cellIdentifier, for: indexPath) as? LoginCollectionViewCell
        else { return UICollectionViewCell()}
        cell.bindData(LoginButtonData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            kakaoLoginPublisher.send()
        case 1:
            appleLoginPublisher.send()
        default:
            break
        }
    }
}
