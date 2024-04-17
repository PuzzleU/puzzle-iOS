//
//  AreaUITableView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/19/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class AreaTableView: UIView {
    
    // MARK: - UI Components
    
    let areaTableView = UITableView().then {
        $0.backgroundColor = .puzzleWhite
    }
    
    private var areaDatas: [String] = []
    
    private let locationIndexSubject: PassthroughSubject<Int, Never> = .init()
    var locationIndexPublisher: AnyPublisher<Int, Never> {
        return locationIndexSubject.eraseToAnyPublisher()
    }
    
    var cancelBag = CancelBag()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        backgroundColor = .puzzleWhite
    }
    
    private func setHierarchy() {
        addSubview(areaTableView)
    }
    
    private func setLayout() {
        areaTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        areaTableView.delegate = self
        areaTableView.dataSource = self
    }
    
    private func setRegister() {
        areaTableView.register(AreaTableViewCell.self, forCellReuseIdentifier: AreaTableViewCell.className)
    }
    
    // MARK: - Methods
    
    func bind(areaData: [String]) {
        self.areaDatas = areaData
    }
}

// MARK: - UITableViewDelegate

extension AreaTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationIndexSubject.send(indexPath.row)
    }
}

// MARK: - UITableViewDataSource

extension AreaTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.areaDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AreaTableViewCell.className, for: indexPath) as? AreaTableViewCell else { return UITableViewCell() }
        
        cell.bindData(text: self.areaDatas[indexPath.row])
        return cell
    }
    
}
