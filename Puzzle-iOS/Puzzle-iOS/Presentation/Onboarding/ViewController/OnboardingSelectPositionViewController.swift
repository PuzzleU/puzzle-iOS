//
//  OnboardingSelectPositionViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class OnboardingSelectPositionViewController: UIViewController {
    
    // MARK: - Properties
    
    private let rootView = OnboardingBaseView()
    
    private var positionCollectionView = OnboardingCollectionView()
    private var viewModel: PositionViewModel
    private var cancelBag = CancelBag()
    private var positionImages: [PositionKeyword] = []
    
    private let imageSubject = PassthroughSubject<Int, Never>()
    var imagePublisher: AnyPublisher<Int, Never> {
        return imageSubject.eraseToAnyPublisher()
    }
    
    private var imageSetSubject = CurrentValueSubject<Set<Int>, Never>([])
    var imageSetPublisher: AnyPublisher<Set<Int>, Never> {
        return imageSetSubject.eraseToAnyPublisher()
    }
    
    private var selectedIndexPath: IndexPath?
    
    // MARK: - UI Components
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("내 포지션을 선택해주세요")
    
    private let alertLabel = UILabel().then {
        let label = StringLiterals.Onboarding.selectPosition
        let specialCharacter = StringLiterals.Onboarding.selectPositionSpecial
        
        $0.highlightSpecialText(
            mainText: label,
            specialTexts: [specialCharacter],
            mainAttributes: [
                .font: UIFont.subTitle3,
                .foregroundColor: UIColor.puzzleGray800
            ],
            specialAttributes: [
                .font: UIFont.subTitle3,
                .foregroundColor: UIColor.puzzlePurple
            ]
        )
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
        bind()
        observe()
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        view.addSubviews(
            naviBar,
            alertLabel,
            positionCollectionView
        )
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
    
    private func bind() {
        let input = PositionViewModel.Input(
            viewDidLoad: self.viewDidLoadPublisher,
            selectImageAtIndex: imagePublisher
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.positionImage
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] images in
                self?.positionImages = images
                self?.positionCollectionView.onboardingCollectionView.reloadData()
            })
            .store(in: cancelBag)
        
        output.selectedIndices
            .receive(on: RunLoop.main)
            .sink { [weak self] selectedIndices in
                print("OnboardingSelectPositionIndex= \(selectedIndices)")
                self?.imageSetSubject.send(selectedIndices)
                self?.positionCollectionView.onboardingCollectionView.reloadData()
                self?.rootView.isEnabledNextButton(isEnabled: !selectedIndices.isEmpty)
            }
            .store(in: cancelBag)
    }
    
    private func observe() {
        rootView.nextButtonTapped.sink { [weak self] _ in
            self?.viewModel.nextButtonTapped.send()
        }.store(in: cancelBag)
    }
}

// MARK: - UICollectionViewDelegate

extension OnboardingSelectPositionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedId = positionImages[indexPath.row].id
        imageSubject.send(selectedId)
        
        print("OnboardingSelectPositionVC 의 \(indexPath.row) 터치 ")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.isSelected = viewModel.selectedPositionIndexes.contains(indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource

extension OnboardingSelectPositionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return positionImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.className, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell()}
        
        let positionKeyword = positionImages[indexPath.row]
        cell.bindData(image: positionKeyword.positionImage)
//        cell.isSelected = imageSetSubject.value.contains(positionKeyword.id)
        return cell
    }
}
