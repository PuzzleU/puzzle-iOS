//
//  RecruitmentNumberPickerViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 5/2/24.
//

import UIKit

import SnapKit
import Then

final class RecruitmentNumberPickerViewController: UIViewController {
    
    // MARK: - Properties
    
    var recruitPeopleLimitLists = (1...10).map { "\($0) 명" }
    
    // MARK: - UIComponents
    
    private let headTitle = LabelFactory.build(text: "모집 인원수", font: .body1)
    private let bodyTitle = LabelFactory.build(text: "구하는 인원 수를 선택해 주세요", font: .subTitle3)
    
    private lazy var vStackView = UIStackView(
        arrangedSubviews: [
            headTitle,
            bodyTitle
        ]
    ).then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 8
    }
    
    let pickerView = UIPickerView().then {
        $0.backgroundColor = .green
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setHierarchy() {
        self.view.addSubviews(
            vStackView,
            pickerView
        )
    }
    
    private func setLayout() {
        
        vStackView.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top).offset(24)
            $0.leading.equalTo(self.view.snp.leading).inset(28)
        }
        
        pickerView.snp.makeConstraints {
            $0.top.equalTo(vStackView.snp.bottom).offset(36)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(100)
            $0.width.equalTo(120)
        }
    }
    
    private func setDelegate() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
}

extension RecruitmentNumberPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        recruitPeopleLimitLists.count
    }
    
}

extension RecruitmentNumberPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return recruitPeopleLimitLists[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
    }
}
