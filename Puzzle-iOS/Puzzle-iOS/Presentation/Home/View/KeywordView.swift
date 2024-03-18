//
//  KeywordView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/2/24.
//

import UIKit

import SnapKit
import Then

final class KeywordView: UIView {
    
    // MARK: - Properties
    
    final let itemSize = CGSize(width: 100, height: 100)
    final let interItemSpacing: CGFloat = 8
    
    private let keyword: [String] = ["전체", "기획", "디자인", "문학", "iOS", "미디어", "예술", "IT", "동적으로 변하는 레이아웃"]
    
    // MARK: - UI Components
    
    lazy var keywordCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.minimumInteritemSpacing = interItemSpacing
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize // 자동 사이즈
        
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
    }
    
    init() {
        super.init(frame: .zero)
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        register()
        selectDefaultKeyword()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        self.backgroundColor = .puzzleWhite
    }
    
    private func setHierarchy() {
        self.addSubview(keywordCollectionView)
    }
    
    private func setLayout() {
        keywordCollectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(3)
            $0.leading.trailing.equalToSuperview().inset(17)
        }
    }
    
    private func setDelegate() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
    
    private func register() {
        keywordCollectionView.register(KeywordCell.self, forCellWithReuseIdentifier: KeywordCell.className)
    }
    
    // MARK: - Methods
    
    // 처음 뷰에 들어오면 "전체" 키워드가 클릭되어 있는 이벤트입니다.
    private func selectDefaultKeyword() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let defaultIndexPath = IndexPath(item: 0, section: 0)
            self.keywordCollectionView.selectItem(at: defaultIndexPath, animated: false, scrollPosition: .left)
            self.collectionView(self.keywordCollectionView, didSelectItemAt: defaultIndexPath)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension KeywordView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension KeywordView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyword.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCell.className, for: indexPath) as? KeywordCell else {
            return UICollectionViewCell()
        }
        
        cell.bindData(with: keyword[indexPath.row])
        return cell
    }
}
