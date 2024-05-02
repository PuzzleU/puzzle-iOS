//
//  PostView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/19/24.
//

import UIKit

import SnapKit
import Then

final class PostView: UIView {
    
    // MARK: - Property
    
    let textFieldPlaceHolder = "제목을 입력해 주세여"
    
    let textViewPlaceholder = "같이 하고 싶은 팀원에 대해 자유롭게 설명해주세요!\n[예시]\n(스킬셋) 특히 포토샵을 잘 다루는 분이면 좋겠어요\n(경험) 공모전 수상 경험이 있는 분이면 좋겠어요\n(경험) 경험이 많지 않아도 같이 개발하며 성장할 수 있는 분이면 좋겠어요\n(지역) 대면 가능한 분만 원해요"
    
    // MARK: - UIComponents
    
    private let competitionSelectionView = PuzzleCustomView.makeInfoView(title: "공모전 선택")
    
    lazy var titleTextField = UITextField().then {
        $0.textColor = .puzzleBlack
        $0.font = .body2
        $0.textColor = .puzzleBlack
        $0.placeholder = self.textFieldPlaceHolder
        $0.setPlaceholderColor(.puzzleGray300)
    }
    
    private let splitView = UIView().then {
        $0.backgroundColor = .puzzleGray300
    }
    
    let recruitCountView = PuzzleCustomView.makeInfoView(title: "모집 인원 수", image: .icDoublePeople)
    let selectionView = PuzzleCustomView.makeInfoView(title: "구인 포지션", image: .icWrench)
    
    private lazy var vStackView = UIStackView(
        arrangedSubviews: [
            competitionSelectionView,
            titleTextField,
            splitView,
            recruitCountView,
            selectionView,
            postTextView,
            postSaveButton
        ]
    ).then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 1
        $0.setCustomSpacing(200, after: postTextView)
    }
    
    lazy var postTextView = UITextView().then {
        $0.font = .body2
        $0.text = self.textViewPlaceholder
        
        $0.isEditable = true
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let attributedString = NSMutableAttributedString(
            string: $0.text,
            attributes: [
                .font: UIFont.body2,
                .foregroundColor: UIColor.puzzleGray400
            ]
        )
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        $0.attributedText = attributedString
        $0.isScrollEnabled = false
        $0.sizeToFit()
        $0.backgroundColor = .puzzleWhite
    }
    
    lazy var postSaveButton = PuzzleMainButton(title: "항목 저장")
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        backgroundColor = .puzzleWhite
    }
    
    private func setHierarchy() {
        addSubviews(vStackView)
    }
    
    private func setLayout() {
        vStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        competitionSelectionView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        titleTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        splitView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        recruitCountView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        selectionView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        postTextView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.greaterThanOrEqualTo(120)
        }
        
        postSaveButton.snp.remakeConstraints {
            $0.height.equalTo(52)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
}
