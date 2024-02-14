//
//  PuzzleDropdownTableView.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/14/24.
//

import UIKit

import SnapKit
import Then

final class PuzzleDropdownTableView: UIView {
    
    let dummyData = ["강아지", "토끼", "이구아나", "뱀파이어", "드래곤볼", "딱따구리딱딱딱", "돼지꿀", "고양이", "새"]
    
    // MARK: - UI Components
    
    private let dropdownTableView = UITableView().then {
        $0.backgroundColor = .puzzleRealWhite
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.register(PuzzleDropDownTableViewCell.self, forCellReuseIdentifier: PuzzleDropDownTableViewCell.reuseIdentifier)
        $0.isHidden = true
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .puzzleRealWhite
        
        setDelegate()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Delegate
    
    private func setDelegate() {
        dropdownTableView.dataSource = self
        dropdownTableView.delegate = self
    }
    
    private func setHierarchy() {
        self.addSubview(dropdownTableView)
    }
    
    private func setLayout() {
        dropdownTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//MARK: - TableView DataSource and Delegate

extension PuzzleDropdownTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PuzzleDropDownTableViewCell.reuseIdentifier, for: indexPath) as? PuzzleDropDownTableViewCell else { return UITableViewCell() }
        cell.bindText(text: dummyData[indexPath.row])
        
        return cell
    }
}

extension PuzzleDropdownTableView: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

