//
//  SettingViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/15/24.
//

import UIKit

import SnapKit

// MARK: - SettingSection

enum SettingSection: Int, CaseIterable {
    case separator1
    case guide
    case separator2
    case personalSetting
    case separator3
    case account
    case separator4
    case appInfo
    case accountDeletion
    
    var cellIdentifier: String {
        switch self {
        case .guide, .personalSetting, .account, .appInfo, .accountDeletion:
            return SettingCell.className
        case .separator1, .separator2, .separator3, .separator4:
            return EmptyCell.className
        }
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .guide, .personalSetting, .account, .appInfo, .accountDeletion:
            return 45
        case .separator1:
            return 12
        case .separator2, .separator3, .separator4:
            return 2
        }
    }
    
    var hasHeader: Bool {
        switch self {
        case .guide, .personalSetting, .account, .appInfo:
            return true
        default:
            return false
        }
    }
}

final class SettingViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private lazy var settingNavigationBar = PuzzleNavigationBar(self, type: .centerTitleWithLeftButton).setTitle("설정")
    private let settingCollectionView = SettingView()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setRegister()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .puzzleWhite
    }
    
    private func setHierarchy() {
        view.addSubviews(
            settingNavigationBar,
            settingCollectionView
        )
    }
    
    private func setLayout() {
        settingNavigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        settingCollectionView.snp.makeConstraints {
            $0.top.equalTo(settingNavigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        settingCollectionView.settingCollectionView.delegate = self
        settingCollectionView.settingCollectionView.dataSource = self
    }
    
    private func setRegister() {
        settingCollectionView.settingCollectionView.register(SettingCell.self, forCellWithReuseIdentifier: SettingCell.className)
        settingCollectionView.settingCollectionView.register(EmptyCell.self, forCellWithReuseIdentifier: EmptyCell.className)
        settingCollectionView.settingCollectionView.register(SettingHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SettingHeaderView.className)
        
    }
    
}

// MARK: - UICollectionViewDelegate

extension SettingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: 탭 이벤트
        print(indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension SettingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SettingSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = SettingSection(rawValue: section) else { return 0 }
        
        switch section {
        case .guide:
            return 3
        case .personalSetting, .account, .accountDeletion:
            return 1
        case .appInfo:
            return 2
        case .separator1, .separator2, .separator3, .separator4:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = SettingSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        if section == .separator1 || section == .separator2 || section == .separator3 || section == .separator4 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCell.className, for: indexPath) as? EmptyCell else {
                return UICollectionViewCell()
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCell.className, for: indexPath) as? SettingCell else {
                return UICollectionViewCell()
            }
            
            switch section {
            case .guide:
                cell.dataBind(title: StringLiterals.Setting.guideSectionTitles[indexPath.row])
            case .personalSetting:
                cell.dataBind(title: StringLiterals.Setting.personalSettingSectionTitle)
            case .account:
                cell.dataBind(title: StringLiterals.Setting.accountSectionTitle)
            case .appInfo:
                cell.dataBind(title: StringLiterals.Setting.appInfoSectionTitles[indexPath.row])
            case .accountDeletion:
                cell.dataBind(title: StringLiterals.Setting.accountDeletionTitle)
            default:
                cell.dataBind(title: "")
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SettingHeaderView.className, for: indexPath) as? SettingHeaderView else {
            return UICollectionReusableView()
        }
        
        let section = SettingSection(rawValue: indexPath.section)
        switch section {
        case .guide:
            headerView.setTitle(StringLiterals.Setting.guideHeaderTitle)
        case .personalSetting:
            headerView.setTitle(StringLiterals.Setting.personalSettingHeaderTitle)
        case .account:
            headerView.setTitle(StringLiterals.Setting.accountHeaderTitle)
        case .appInfo:
            headerView.setTitle(StringLiterals.Setting.appInfoHeaderTitle)
        default:
            break
        }
        
        return headerView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SettingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        guard let section = SettingSection(rawValue: indexPath.section) else { return CGSize(width: 0, height: 0) }
        
        switch section {
        case .separator2, .separator3, .separator4:
            return CGSize(width: screenWidth - 48, height: section.cellHeight)
        default:
            return CGSize(width: screenWidth, height: section.cellHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let sectionType = SettingSection(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .guide, .personalSetting, .account, .appInfo, .accountDeletion:
            return 0
        default:
            return 18
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        
        if SettingSection(rawValue: section)?.hasHeader ?? false {
            return CGSize(width: screenWidth, height: 40)
        }
        return CGSize.zero
    }
    
}
