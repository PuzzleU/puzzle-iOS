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
    
    // MARK: - Properties
    
    var dropdownData: [String] = []
    
    // MARK: - UI Components
    
    let dropdownTableView = UITableView().then {
        $0.backgroundColor = .puzzleWhite
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.isScrollEnabled = true
        $0.separatorStyle = .none
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        setDelegate()
        setHierarchy()
        setLayout()
        setRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegate
    
    private func setDelegate() {
        dropdownTableView.dataSource = self
        dropdownTableView.delegate = self
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        self.addSubview(dropdownTableView)
    }
    
    private func setLayout() {
        dropdownTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setRegister() {
        dropdownTableView.register(PuzzleDropDownTableViewCell.self, forCellReuseIdentifier: PuzzleDropDownTableViewCell.reuseIdentifier)
    }
    
    // MARK: - Notification
    
    func sendTitle(title: String) {
        NotificationCenter.default.post(name: NSNotification.Name("updatePuzzleDropdownTitle"), object: self, userInfo: ["title": title])
    }
}

// MARK: - TableView DataSource and Delegate

extension PuzzleDropdownTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropdownData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PuzzleDropDownTableViewCell.reuseIdentifier, for: indexPath) as? PuzzleDropDownTableViewCell else { return UITableViewCell() }
        cell.bindText(text: dropdownData[indexPath.row])
        return cell
    }
}

extension PuzzleDropdownTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendTitle(title: dropdownData[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NumberLiterals.DropDown.dropDownHeight
    }
}
