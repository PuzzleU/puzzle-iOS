//
//  JobPositionViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 6/3/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class JobPositionViewController: UIViewController {
    
    // MARK: - Properties
    
    let positions = ["개발", "기획", "마케팅", "디자인", "데이터", "기타"]
    var keywords: [String] = []
    
    // MARK: - UIComponents
    
    let positionTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorColor = .white
        $0.isScrollEnabled = false
    }
    
    private let divideView = UIView().then {
        $0.backgroundColor = .puzzleGray100
    }
    
    lazy var keywordCollectionView: UICollectionView = {
        let layout = CompositionalLayout.positionSelectCollectionViewLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    private let saveButton = PuzzleMainButton(title: "항목 저장")
    
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
        view.backgroundColor = .white
        
        let headerView = createTableHeaderView()
        positionTableView.tableHeaderView = headerView
    }
    
    private func setHierarchy() {
        view.addSubviews(
            positionTableView,
            divideView,
            keywordCollectionView,
            saveButton
        )
    }
    
    private func setLayout() {
        positionTableView.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top).inset(31)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(185)
        }
        
        divideView.snp.makeConstraints {
            $0.height.equalTo(163)
            $0.top.equalTo(positionTableView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        keywordCollectionView.snp.makeConstraints {
            $0.top.equalTo(divideView.snp.top).offset(25)
            $0.leading.equalTo(divideView.snp.leading).offset(34)
        }
    }

    private func setDelegate() {
        positionTableView.delegate = self
        positionTableView.dataSource = self
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
    
    private func setRegister() {
        positionTableView.register(PositionCell.self, forCellReuseIdentifier: PositionCell.className)
        keywordCollectionView.register(PositionCheckCell.self, forCellWithReuseIdentifier: PositionCheckCell.className)
        
    }
    
    private func createTableHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let headerLabel = UILabel().then {
            $0.text = "포지션 선택"
            $0.textAlignment = .left
            $0.font = .body2
        }
        
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        return headerView
    }
}

// MARK: - UITableViewDataSource

extension JobPositionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return positions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PositionCell.className, for: indexPath) as? PositionCell else { return UITableViewCell() }
        
        cell.bindData(text: positions[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension JobPositionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 테이블뷰 에서 탭을 하면
        // 컬렉션 뷰로 데이터를 전달 시키면 된다.
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        return
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: - UICollectionViewDelegate

extension JobPositionViewController: UICollectionViewDelegate {
    
    // 컬렉션뷰에서 탭을 하면 해당 데이터 사라지게 하면 됩니다.
    
    
}

// MARK: - UICollectionViewDataSource

extension JobPositionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PositionCheckCell.className, for: indexPath) as? PositionCheckCell
        else { return UICollectionViewCell() }
        
        cell.bindData(text: keywords[indexPath.row])
        
        return cell
    }
}
