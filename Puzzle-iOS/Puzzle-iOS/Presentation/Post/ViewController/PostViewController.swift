//
//  PostViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/19/24.
//

import UIKit
import Combine

final class PostViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private let postView = PostView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = postView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        setRegister()
    }

    private func setDelegate() {
        postView.postTextView.delegate = self
    }
    
    private func setRegister() {
        
    }
    
}

extension PostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            activityTextView.textColor = .g3
            activityTextView.text = placeholder
            
        } else if textView.text == placeholder {
            activityTextView.textColor = .g1
            activityTextView.text = nil
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = activityTextView.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        // 커서 위치 저장
        let selectedRange = textView.selectedRange
        
        let attributedString = NSMutableAttributedString(string: textView.text)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        textView.attributedText = attributedString
        textView.font = .b3
        textView.textColor = .g1
        
        // 커서 위치 다시 설정
        textView.selectedRange = selectedRange
        
        guard let courseTitleTextFieldText = self.courseTitleTextField.text else { return }
        textDidChanged(courseTitleTextFieldText, text)
        
        if text.count > self.activityTextMaxLength {
            self.activityTextView.deleteBackward()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == placeholder {
            activityTextView.textColor = .g3
            activityTextView.text = placeholder
        }
    }
}
