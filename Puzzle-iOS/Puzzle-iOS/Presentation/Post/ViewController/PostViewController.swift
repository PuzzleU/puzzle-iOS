//
//  PostViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/19/24.
//

import UIKit
import Combine

final class PostViewController: UIViewController {
    
    // MARK: - Property
    
    private lazy var textFieldPlaceholder = rootView.textFieldPlaceHolder
    private lazy var textViewPlaceholder = rootView.textViewPlaceholder
    
    private let vm = PostViewModel()
    
    var cancelBag = CancelBag()
    
    private var userInput: String = ""
    // MARK: - UIComponents
    
    private let rootView = PostView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        bind()
        setTapGesture()
        setAddTarget()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setDelegate() {
        rootView.postTextView.delegate = self
        rootView.titleTextField.delegate = self
    }
    
    private func bind() {
        let input = PostViewModel.Input(
            postTextViewDidChange: rootView.postTextView.textDidChangePublisher,
            postTextBeginEditingChange: rootView.postTextView.textDidBeginEditingPublisher,
            postTextEndEditingChange: rootView.postTextView.textDidEndEditingPublisher
        )
        
        let output = vm.transform(from: input, cancelBag: cancelBag)
        
        output.postTextViewText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [unowned self] text in
                self.userInput = text
            }.store(in: cancelBag)
        
        output.postTextViewBeginEditingChange
            .sink { [unowned self] _ in
                if rootView.postTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.rootView.postTextView.textColor = .puzzleGray400
                    self.rootView.postTextView.text = self.textViewPlaceholder
                } else if rootView.postTextView.text == self.textViewPlaceholder {
                    self.rootView.postTextView.textColor = .puzzleGray800
                    self.rootView.postTextView.text = nil
                }
            }
            .store(in: cancelBag)
        
        output.postTextEndEditingChange
            .sink { [unowned self] _ in
                if self.rootView.postTextView.text?.isEmpty ?? true {
                    self.rootView.postTextView.textColor = .puzzleGray300
                    self.rootView.postTextView.text = self.rootView.textViewPlaceholder
                }
                
            }.store(in: cancelBag)
        
        rootView.recruitCountView.gesture(.tap())
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.showBottomSheet()
            }.store(in: cancelBag)
    }
    
    private func setTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    private func setAddTarget() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ sender: Notification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        if rootView.postTextView.isFirstResponder {
            let keyboardHeight = keyboardFrame.height * 0.7
            self.view.frame.origin.y -= keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        if rootView.postTextView.isFirstResponder {
            let keyboardHeight = keyboardFrame.height * 0.7
            self.view.frame.origin.y += keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UITextFieldDelegate

extension PostViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == rootView.titleTextField {
            rootView.postTextView.becomeFirstResponder()
            return true
        }
        return false
    }
}

// MARK: - UITextViewDelegate

extension PostViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = textView.text ?? ""
        
        // NSRange를 Swift의 Range로 변환합니다.
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // 변경될 텍스트를 적용하여 새로운 전체 텍스트를 생성합니다.
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        // 업데이트된 텍스트의 길이가 10을 초과하는지 확인하고, 초과하면 false를 반환하여 입력을 거부합니다.
        if updatedText.count > 150 {
            self.showToast(message: "글자수가 넘어 갑니다.")
            return false
        }
        
        // 길이 제한에 걸리지 않는 경우 true를 반환하여 텍스트 변경을 허용합니다.
        return true
    }
}

extension PostViewController {
    func showBottomSheet() {
        let bottomSheetVC = BottomSheetViewController(bottomType: .middle)
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetVC, animated: false, completion: nil)
    }
}
