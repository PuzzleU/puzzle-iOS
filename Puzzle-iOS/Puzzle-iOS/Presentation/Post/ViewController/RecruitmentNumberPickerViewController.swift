//
//  RecruitmentNumberPickerViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 5/2/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class RecruitmentNumberPickerViewController: UIViewController {
    
    // MARK: - Properties
    
    private let recruitPeopleLimitLists = pickerDummyData
    
    private let itemSubject: PassthroughSubject<String, Never> = .init()
    var itemPublisher: AnyPublisher<String, Never> {
        return itemSubject.eraseToAnyPublisher()
    }
    // MARK: - UIComponents
    
    private let headTitle = LabelFactory.build(
        text: "모집 인원수",
        font: .body1,
        textColor: .puzzleGray800
    )
    
    private let bodyTitle = LabelFactory.build(
        text: "구하는 인원 수를 선택해 주세요",
        font: .subTitle3,
        textColor: .puzzleGray400
    )
    
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
    
    private let pickerView = UIPickerView().then {
        $0.backgroundColor = .clear
    }
    
    lazy var saveButton = PuzzleMainButton(title: "항목저장").then { $0.isSelected = true }
    
    private let upLine = UIView().then { $0.backgroundColor = .black }
    private let underLine = UIView().then { $0.backgroundColor = .black }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.setPickerView()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.itemSubject.send("1 명")
    }
    
    private func setHierarchy() {
        self.view.addSubviews(
            vStackView,
            pickerView,
            saveButton
        )
    }
    
    private func setLayout() {
        vStackView.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top).offset(24)
            $0.leading.equalToSuperview().inset(28)
        }
        
        pickerView.snp.makeConstraints {
            $0.top.equalTo(vStackView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(130)
        }
        
        saveButton.snp.remakeConstraints {
            $0.top.equalTo(pickerView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(332)
            $0.height.equalTo(52)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func setPickerView() {
        pickerView.subviews[1].backgroundColor = .clear
        
        pickerView.subviews[1].addSubview(upLine)
        pickerView.subviews[1].addSubview(underLine)
        
        upLine.snp.makeConstraints {
            $0.width.equalTo(pickerView.snp.width)
            $0.height.equalTo(0.8)
            $0.top.equalToSuperview().offset(5)
        }
        
        underLine.snp.makeConstraints {
            $0.width.equalTo(pickerView.snp.width)
            $0.height.equalTo(0.8)
            $0.top.equalToSuperview().offset(40)
        }
    }
}

// MARK: - UIPickerViewDataSource

extension RecruitmentNumberPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        recruitPeopleLimitLists.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 44))
        
        let puzzleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 44))
        puzzleLabel.text = recruitPeopleLimitLists[row]
        puzzleLabel.textAlignment = .center
        puzzleLabel.font = .body1
        puzzleLabel.textColor = .black
        
        view.addSubview(puzzleLabel)
        
        return view
    }
}

// MARK: - UIPickerViewDelegate

extension RecruitmentNumberPickerViewController: UIPickerViewDelegate {
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return recruitPeopleLimitLists[row]
    //    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.itemSubject.send(recruitPeopleLimitLists[row])
    }
}
