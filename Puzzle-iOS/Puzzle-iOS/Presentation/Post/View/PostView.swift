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
            postTextView,
            postSaveButton
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
        scrollView.addSubview(contentView)
        contentView.addSubview(vStackView)
        recruitCountView.addSubview(recruitCountLabel)
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
        
        postTextView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(444)
        }
        
        postSaveButton.snp.remakeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        recruitCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
