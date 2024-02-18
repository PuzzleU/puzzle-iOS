//
//  OnboardingInterestSelectionVC.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit

import SnapKit
import Then

class OnboardingInterestSelectionVC: UIViewController {
    
    // MARK: - Properties
    
    private let rootView = OnboardingBaseView()
    
    private var interestCollectionView = InterestSelectionCollectionView()
    private var viewModel: InterestViewModel
    private var cancelBag = CancelBag()
    
    // MARK: - UI Components
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("관심있는 분야를 모두 선택해주세요")
    
    private let alertLabel = UILabel().then {
        let label = "관심 분야에 맞는 활동을 추천해드려요."
        $0.highlightSpecialText(mainText: label, specialTexts: ["활동"], mainAttributes: [.font: UIFont.body3, .foregroundColor: UIColor.black], specialAttributes: [.font: UIFont.body3, .foregroundColor: UIColor.puzzlePurple])
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
        setUI()
        setLayout()
        register()
        delegate()
        setupNaviBindings()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.addSubviews(naviBar, alertLabel, interestCollectionView)
        
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
            $0.bottom.equalToSuperview()
        }
    }
    
    private func register() {
        interestCollectionView.mapCollectionView.register(InterestSelectionViewCell.self, forCellWithReuseIdentifier: InterestSelectionViewCell.className)
        
        interestCollectionView.mapCollectionView.register(InterestSelectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InterestSelectionHeaderView.className)
    }
    
    private func delegate() {
        interestCollectionView.mapCollectionView.delegate = self
        interestCollectionView.mapCollectionView.dataSource = self
    }
    
}

// MARK: - Methods

extension OnboardingInterestSelectionVC {
    private func setupNaviBindings() {
        naviBar.resetLeftButtonAction({ [weak self] in
            self?.viewModel.backButtonTapped.send()
        }, .leftTitleWithLeftButton)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension OnboardingInterestSelectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return viewModel.competitions.count
        case 1: return viewModel.jobs.count
        case 2: return viewModel.studys.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestSelectionViewCell.className, for: indexPath) as? InterestSelectionViewCell else {
            return UICollectionViewCell()
        }
        let text: String
        switch indexPath.section {
        case 0:
            text = viewModel.competitions[indexPath.row]
        case 1:
            text = viewModel.jobs[indexPath.row]
        case 2:
            text = viewModel.studys[indexPath.row]
        default:
            text = ""
        }
        cell.bindData(with: text)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InterestSelectionHeaderView.className, for: indexPath) as? InterestSelectionHeaderView else {
                return UICollectionReusableView()
            }
            
            let sectionTitle: String
            switch indexPath.section {
            case 0:
                sectionTitle = "공모전"
            case 1:
                sectionTitle = "직무"
            case 2:
                sectionTitle = "스터디"
            default:
                sectionTitle = ""
            }
            
            headerView.bindData(with: sectionTitle)
            
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingInterestSelectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text: String
        switch indexPath.section {
        case 0:
            text = viewModel.competitions[indexPath.row]
        case 1:
            text = viewModel.jobs[indexPath.row]
        case 2:
            text = viewModel.studys[indexPath.row]
        default:
            text = ""
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
    
    // 섹션 간 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 35, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 35)
    }
}
