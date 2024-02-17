//
//  OnboardingSelectProfileImageVC.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit

class OnboardingSelectProfileImageVC: UIViewController {

    // MARK: - Properties
    
    private let rootView = OnboardingBaseView()
    
    private var animalView = AnimalView()
    private var viewModel: AnimalsViewModel
    private var cancelBag = CancelBag()
    
    // MARK: - UI Components
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("퍼즐에서 사용할 프로필을 선택해주세요")
    
    private let alertLabel = UILabel().then {
        let label = "내 프로필로 만들고 싶은 동물을 하나 선택해주세요."
        $0.highlightSpecialText(mainText: label, specialTexts: ["내 프로필"], mainAttributes: [.font: UIFont.body3, .foregroundColor: UIColor.black], specialAttributes: [.font: UIFont.body3, .foregroundColor: UIColor.puzzlePurple])
    }
    
    // MARK: - Life Cycles
    
    init(viewModel: AnimalsViewModel) {
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
        setUI()
        setLayout()
        register()
        delegate()
        setupNaviBindings()
        bindViewModel()
    }
    
    private func setUI() {
        view.addSubviews(naviBar, alertLabel, animalView)
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
        
        animalView.snp.makeConstraints {
            $0.top.equalTo(alertLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.bottom.equalToSuperview().inset(227)
        }
    }
    
    private func register() {
        animalView.animalCollectionView.register(AnimalCollectionViewCell.self, forCellWithReuseIdentifier: AnimalCollectionViewCell.className)
    }
    
    private func delegate() {
        animalView.animalCollectionView.delegate = self
        animalView.animalCollectionView.dataSource = self
    }

}

// MARK: - Methods

extension OnboardingSelectProfileImageVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("갯수 \(viewModel.animalImages.count)")
        return viewModel.animalImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimalCollectionViewCell.className, for: indexPath) as? AnimalCollectionViewCell else { return UICollectionViewCell()}
        cell.bind(with: viewModel.animalImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    private func setupNaviBindings() {
        naviBar.resetLeftButtonAction({ [weak self] in
            self?.viewModel.backButtonTapped.send()
        }, .leftTitleWithLeftButton)
    }
    
    private func bindViewModel() {
        viewModel.$animalImages
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.animalView.animalCollectionView.reloadData()
            }
            .store(in: cancelBag)
    }
}

