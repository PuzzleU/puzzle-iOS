//
//  OnboardingSelectPositionViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingSelectPositionViewController: UIViewController {
    
    // MARK: - Properties
    
    private let rootView = OnboardingBaseView()
    
    private var positionCollectionView = OnboardingCollectionView()
    private var viewModel: PositionViewModel
    private var cancelBag = CancelBag()
    
    // MARK: - UI Components
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("내 포지션을 선택해주세요")
    
    private let alertLabel = UILabel().then {
        let label = "포지션에 맞는 공모전을 추천해드려요.\n(최대 2개까지 선택 가능)"
        $0.highlightSpecialText(mainText: label, specialTexts: ["공모전"], mainAttributes: [.font: UIFont.body3, .foregroundColor: UIColor.black], specialAttributes: [.font: UIFont.body3, .foregroundColor: UIColor.puzzlePurple])
        $0.numberOfLines = 0
    }
    
    // MARK: - Life Cycles
    
    init(viewModel: PositionViewModel) {
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
        setDelegate()
        setLayout()
        register()
        setNaviBindings()
        bindViewModel()
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        view.addSubviews(naviBar, alertLabel, positionCollectionView)
    }
    
    private func setLayout() {
        naviBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8 + 5)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        alertLabel.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(8)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(46)
        }
        
        positionCollectionView.snp.makeConstraints {
            $0.top.equalTo(alertLabel.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.bottom.equalToSuperview().inset(227)
        }
    }
    
    private func register() {
        positionCollectionView.onboardingCollectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.className)
    }
    
    private func setDelegate() {
        positionCollectionView.onboardingCollectionView.delegate = self
        positionCollectionView.onboardingCollectionView.dataSource = self
    }
    
}

// MARK: - Methods

extension OnboardingSelectPositionViewController {
    private func setNaviBindings() {
        naviBar.resetLeftButtonAction({ [weak self] in
            self?.viewModel.backButtonTapped.send()
        }, .leftTitleWithLeftButton)
    }
    
    private func bindViewModel() {
        viewModel.$positionImages
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.positionCollectionView.onboardingCollectionView.reloadData()
            }
            .store(in: cancelBag)
    }
}

// MARK: - UICollectionViewDelegate

extension OnboardingSelectPositionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("OnboardingSelectPositionVC 의 \(indexPath.row) 터치 ")
    }
}


// MARK: - UICollectionViewDataSource

extension OnboardingSelectPositionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.positionImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.className, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell()}
        cell.bindData(with: viewModel.positionImages[indexPath.row])
        return cell
    }
}
