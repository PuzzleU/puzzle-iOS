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
    
    private lazy var placeholder = postView.placeholder
    
    private let vm = PostViewModel()
    
    var cancelBag = CancelBag()
    
    private var userInput: String = ""
    // MARK: - UIComponents
    
    private let postView = PostView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = postView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        bind()
    }
    
    private func setDelegate() {
        postView.postTextView.delegate = self
    }
    
    private func bind() {
        let input = PostViewModel.Input(
            postTextViewDidChange: postView.postTextView.textDidChangePublisher,
            postTextBeginEditingChange: postView.postTextView.textDidBeginEditingPublisher,
            postTextEndEditingChange: postView.postTextView.textDidEndEditingPublisher
        )
        
        let output = vm.transform(from: input, cancelBag: cancelBag)
        
        output.postTextViewText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [unowned self] text in
                self.userInput = text
            }.store(in: cancelBag)
        
        output.postTextViewBeginEditingChange
            .sink { [unowned self] _ in
                if postView.postTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.postView.postTextView.textColor = .puzzleGray400
                    self.postView.postTextView.text = self.placeholder
                } else if postView.postTextView.text == self.placeholder {
                    self.postView.postTextView.textColor = .puzzleGray800
                    self.postView.postTextView.text = nil
                }
            }
            .store(in: cancelBag)
        
        output.postTextEndEditingChange
            .sink { [unowned self] _ in
                if self.postView.postTextView.text?.isEmpty ?? true {
                    self.postView.postTextView.textColor = .puzzleGray300
                    self.postView.postTextView.text = self.postView.placeholder
                }
                
            }.store(in: cancelBag)
        
        postView.recruitCountView.gesture(.tap())
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.showBottomSheet()
            }.store(in: cancelBag)
    }
    
}

extension PostViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = textView.text ?? ""
        
        // NSRange를 Swift의 Range로 변환합니다.
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // 변경될 텍스트를 적용하여 새로운 전체 텍스트를 생성합니다.
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        // 업데이트된 텍스트의 길이가 10을 초과하는지 확인하고, 초과하면 false를 반환하여 입력을 거부합니다.
        if updatedText.count > 10 {
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
