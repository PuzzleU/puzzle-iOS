//
//  OnboardingSelectInterestViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit
import Combine

import SnapKit
import Then

@frozen
enum InterestSectionType: Int, CaseIterable {
    case competitions = 0
    case jobs
    case studys
    
    var title: String {
        switch self {
        case .competitions:
            return "공모전"
        case .jobs:
            return "직무"
        case .studys:
            return "스터디"
        }
    }
}

final class OnboardingSelectInterestViewController: UIViewController {
    
    // MARK: - Properties
    
    private let rootView = OnboardingBaseView()
    
    private var interestCollectionView = InterestSelectionCollectionView()
    private var viewModel: InterestViewModel
    private var cancelBag = CancelBag()
    
    private var competitionKeywords: [InterestKeyword] = []
    private var jobKeywords: [InterestKeyword] = []
    private var studyKeywords: [InterestKeyword] = []
    
    private let keywordSubject: PassthroughSubject<Int, Never> = .init()
    var keywordPublisher: AnyPublisher<Int, Never> {
        return keywordSubject.eraseToAnyPublisher()
    }
    
    private let keywordSetSubject: PassthroughSubject<Set<Int>, Never> = .init()
    var keywordSetPublisher: AnyPublisher<Set<Int>, Never> {
        return keywordSetSubject.eraseToAnyPublisher()
    }
    
    private var selectedIndexPaths: [IndexPath] = []
    
    // MARK: - UI Components
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("관심있는 분야를 모두 선택해주세요")
    
    private let alertLabel = UILabel().then {
        let label = StringLiterals.Onboarding.selectInterest
        let specialCharacter = StringLiterals.Onboarding.selectInterestSpecial
        
        $0.highlightSpecialText(
            mainText: label,
            specialTexts: [specialCharacter],
            mainAttributes: [
                .font: UIFont.subTitle3,
                .foregroundColor: UIColor.black
            ],
            specialAttributes: [
                .font: UIFont.subTitle3,
                .foregroundColor: UIColor.puzzlePurple
            ]
        )
        $0.numberOfLines = 0
    }
    
    // MARK: - Life Cycles
    
    init(viewModel: InterestViewModel) {
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
        
        bind()
        setHierarchy()
        setLayout()
        register()
        setNaviBind()
        observe()
        setDelegate()
    }
    
    // MARK: - UI & Layout
    private func setHierarchy() {
        view.addSubviews(
            naviBar,
            alertLabel,
            interestCollectionView
        )
        rootView.bringNextButtonToFront()
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
        
        interestCollectionView.snp.makeConstraints {
            $0.top.equalTo(alertLabel.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-70)
        }
    }
    
    private func register() {
        interestCollectionView.mapCollectionView.register(InterestSelectionViewCell.self, forCellWithReuseIdentifier: InterestSelectionViewCell.className)
        
        interestCollectionView.mapCollectionView.register(InterestSelectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InterestSelectionHeaderView.className)
    }
    
    private func setDelegate() {
        interestCollectionView.mapCollectionView.delegate = self
        interestCollectionView.mapCollectionView.dataSource = self
    }
    
}

// MARK: - Methods

extension OnboardingSelectInterestViewController {
    private func setNaviBind() {
        naviBar.resetLeftButtonAction({ [weak self] in
            self?.viewModel.backButtonTapped.send()
        }, .leftTitleWithLeftButton)
    }
    
    private func observe() {
        rootView.nextButtonTapped.sink { [weak self] _ in
            self?.viewModel.nextButtonTapped.send()
        }.store(in: cancelBag)
    }
    
    private func bind() {
        let input = InterestViewModel.Input(
            viewDidLoad: self.viewDidLoadPublisher,
            selectKeyWordIndex: keywordPublisher
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.competitionKeywords
            .receive(on: RunLoop.main)
            .sink { [weak self] keywords in
                self?.competitionKeywords = keywords
                self?.interestCollectionView.mapCollectionView.reloadData()
            }
            .store(in: cancelBag)
        
        output.jobKeywords
            .receive(on: RunLoop.main)
            .sink { [weak self] keywords in
                self?.jobKeywords = keywords
                self?.interestCollectionView.mapCollectionView.reloadData()
            }
            .store(in: cancelBag)
        
        output.studyKeywords
            .receive(on: RunLoop.main)
            .sink { [weak self] keywords in
                self?.studyKeywords = keywords
                self?.interestCollectionView.mapCollectionView.reloadData()
            }
            .store(in: cancelBag)
        
        output.selectkeywordIndex
            .receive(on: RunLoop.main)
            .sink { [weak self] selectedKeywords in
                self?.interestCollectionView.mapCollectionView.reloadData()
                self?.keywordSetSubject.send(selectedKeywords)
                self?.rootView.isEnabledNextButton(isEnabled: !selectedKeywords.isEmpty)
            }
            .store(in: cancelBag)
    }
}

// MARK: - UICollectionViewDelegate

extension OnboardingSelectInterestViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sectionType = InterestSectionType(rawValue: indexPath.section)!
        let keywordId: Int
        switch sectionType {
        case .competitions:
            keywordId = competitionKeywords[indexPath.row].id
        case .jobs:
            keywordId = jobKeywords[indexPath.row].id
        case .studys:
            keywordId = studyKeywords[indexPath.row].id
        }
        
        self.keywordSubject.send(keywordId)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let sectionType = InterestSectionType(rawValue: indexPath.section) else { return }
        
        let keywordId: Int
        switch sectionType {
        case .competitions:
            keywordId = competitionKeywords[indexPath.row].id
        case .jobs:
            keywordId = jobKeywords[indexPath.row].id
        case .studys:
            keywordId = studyKeywords[indexPath.row].id
        }
        
        // 셀의 선택 상태를 설정합니다.
        cell.isSelected = viewModel.selectedKeywords.contains(keywordId)
    }
}

// MARK: - UICollectionViewDataSource

extension OnboardingSelectInterestViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return InterestSectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = InterestSectionType(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .competitions:
            return competitionKeywords.count
        case .jobs:
            return jobKeywords.count
        case .studys:
            return studyKeywords.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestSelectionViewCell.className, for: indexPath) as? InterestSelectionViewCell,
              let sectionType = InterestSectionType(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        let text: String
        switch sectionType {
        case .competitions:
            text = competitionKeywords[indexPath.row].name
        case .jobs:
            text = jobKeywords[indexPath.row].name
        case .studys:
            text = studyKeywords[indexPath.row].name
        }
        
        cell.bindData(with: text)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let sectionType = InterestSectionType(rawValue: indexPath.section),
              let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InterestSelectionHeaderView.className, for: indexPath) as? InterestSelectionHeaderView else {
            return UICollectionReusableView()
        }
        
        headerView.bindData(with: sectionType.title)
        return headerView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingSelectInterestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let sectionType = InterestSectionType(rawValue: indexPath.section) else { return .zero }
        
        let text: String
        switch sectionType {
        case .competitions:
            text = competitionKeywords[indexPath.row].name
        case .jobs:
            text = jobKeywords[indexPath.row].name
        case .studys:
            text = studyKeywords[indexPath.row].name
        }
        
        let textSize = (text as NSString).size(withAttributes: [.font: UIFont.body2])
        let cellWidth = textSize.width + 34
        return CGSize(width: cellWidth, height: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8 // 아이템 간 최소 간격
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8 // 라인 간 최소 간격
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 35, right: 0) // 섹션 간 간격 설정
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 35) // 헤더 뷰 높이 설정
    }
}
