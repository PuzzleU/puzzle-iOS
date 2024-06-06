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
    
    let textFieldPlaceHolder = StringLiterals.Post.textFieldPlaceholderLabel
    let textViewPlaceholder = StringLiterals.Post.textViewPlaceholderLabel
    
    private let keywordColors: [String: UIColor] = [
        "개발": .chip1,
        "기획": .chip5,
        "마케팅": .chip2,
        "디자인": .chip4,
        "데이터": .chip3,
        "기타": .puzzleGray500
    ]
    
    // MARK: - UIComponents
    
    let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let competitionSelectionView = PuzzleCustomView.makeInfoView(
        title: StringLiterals.Post.competitionSelectionViewLabel
    )
    
    lazy var titleTextField = UITextField().then {
        $0.textColor = .puzzleBlack
        $0.font = .body2
        $0.placeholder = self.textFieldPlaceHolder
        $0.setPlaceholderColor(.puzzleGray300)
    }
    
    private let splitView = UIView().then {
        $0.backgroundColor = .puzzleGray300
    }
    
    let recruitCountView = PuzzleCustomView.makeInfoView(
        title: StringLiterals.Post.recruitCountViewLabel,
        image: .icDoublePeople
    )
    
    let selectPositionView = PuzzleCustomView.makeInfoView(
        title: StringLiterals.Post.selectPositionViewLabel,
        image: .icWrench
    )
    
    private let selectPositionChipsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .fill
        $0.distribution = .fillProportionally
    }
    
    let recruitCountLabel = LabelFactory.build(
        text: "",
        font: .subTitle3
    )
    
    lazy var postTextView = UITextView().then {
        $0.font = .body2
        $0.text = self.textViewPlaceholder
        $0.textColor = .puzzleGray400
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
    
    lazy var postSaveButton = PuzzleMainButton(
        title: StringLiterals.Post.postSaveButtonLabel
    )
    
    private lazy var vStackView = UIStackView(
        arrangedSubviews: [
            competitionSelectionView,
            titleTextField,
            splitView,
            recruitCountView,
            selectPositionView,
            selectPositionChipsStackView,
            postTextView
        ]
    ).then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 1
    }
    
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
        addSubview(scrollView)
        scrollView.addSubviews(contentView, postSaveButton)
        contentView.addSubview(vStackView)
        recruitCountView.addSubview(recruitCountLabel)
        selectPositionView.addSubview(selectPositionChipsStackView)
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.height.greaterThanOrEqualToSuperview().priority(.low)
        }
        
        vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(21)
            $0.width.equalToSuperview().offset(-42)
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
        
        selectPositionView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        selectPositionChipsStackView.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.leading.equalToSuperview()
            $0.bottom.equalTo(selectPositionView.snp.bottom).inset(4)
        }
        
        postTextView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        
        recruitCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Methods
    
    func updatePositionChips(positions: [String]) {
        
        guard !positions.isEmpty else {
            
            // 이 부분 없으면 Chips 하나가 남아서 있어야함
            selectPositionChipsStackView.arrangedSubviews.forEach {
                $0.removeFromSuperview()
            }
            
            // 높이 다시 되돌리기
            selectPositionView.snp.updateConstraints {
                $0.height.equalTo(40)
            }
            return
        }
        
        selectPositionChipsStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        for position in positions {
            let backgroundColor = keywordColors[position] ?? .puzzleGray500
            
            let chipView = KeywordFactory.build(
                text: position,
                font: .body2,
                backgroundColor: backgroundColor
            )
            selectPositionChipsStackView.addArrangedSubview(chipView)
        }
        
        selectPositionView.snp.updateConstraints {
            $0.height.equalTo(60)
        }
        
        layoutIfNeeded()
    }
}
