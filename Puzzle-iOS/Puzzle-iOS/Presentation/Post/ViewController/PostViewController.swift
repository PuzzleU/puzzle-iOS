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
    
    private var numberOfPeopleData: Int?
    private var positionDatas: [String] = [] {
        didSet {
            updatePositionChips()
        }
    }
    
    private lazy var textFieldPlaceholder = rootView.textFieldPlaceHolder
    private lazy var textViewPlaceholder = rootView.textViewPlaceholder
    
    private let viewModel: PostViewModel
    
    var cancelBag = CancelBag()
    
    private var userInput: String = ""
    
    // MARK: - UIComponents
    
    private let rootView = PostView()
    
    // MARK: - Life Cycles
    
    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    // MARK: - Methods
    
    private func setDelegate() {
        rootView.postTextView.delegate = self
        rootView.titleTextField.delegate = self
    }
    
    private func bind() {
        let input = PostViewModel.Input(
            postTextViewDidChange: rootView.postTextView.textDidChangePublisher,
            postTextBeginEditingChange: rootView.postTextView.textDidBeginEditingPublisher,
            postTextEndEditingChange: rootView.postTextView.textDidEndEditingPublisher,
            didUploadTapped: rootView.postSaveButton.tapPublisher
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
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
                self?.showRecruitNumberBottomSheet()
            }.store(in: cancelBag)
        
        rootView.selectPositionView.gesture(.tap())
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.showJobPositionBottomSheet()
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
    
    private func updatePositionChips() {
        // Chips에 따라 동적으로
        rootView.updatePositionChips(positions: positionDatas)
    }
    
    // MARK: - Objc function
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: keyboardFrame.size.height,
            right: 0.0)
        
        rootView.scrollView.contentInset = contentInset
        rootView.scrollView.scrollIndicatorInsets = contentInset
        
        if rootView.postTextView.isFirstResponder {
            let contentViewHeight = rootView.scrollView.contentSize.height
            let textViewHeight = rootView.postTextView.frame.height
            let textViewOffsetY = contentViewHeight - (contentInset.bottom + textViewHeight)
            
            let position = CGPoint(x: 0, y: textViewOffsetY + 225)
            rootView.scrollView.setContentOffset(position, animated: true)
            return
        }
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        let contentInset = UIEdgeInsets.zero
        rootView.scrollView.contentInset = contentInset
        rootView.scrollView.scrollIndicatorInsets = contentInset
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
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        if updatedText.count > 150 {
            self.showToast(message: "글자수가 넘어 갑니다.")
            return false
        }
        
        return true
    }
}

extension PostViewController {
    func showRecruitNumberBottomSheet() {
        
        let contentViewController = RecruitmentNumberPickerViewController()
        let bottomSheetVC = BottomSheetViewController(
            bottomType: .low,
            contentViewController: contentViewController,
            upScroll: false
        )
        
        contentViewController
            .itemPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] recruitCount in
                guard let numberString = recruitCount.components(separatedBy: " ").first,
                      let numberOfPeople = Int(numberString) else { return }
                
                self?.numberOfPeopleData = numberOfPeople
                self?.recruitBind(recruitCount: recruitCount)
                print("모집 인원수 \(numberOfPeople)")
            }.store(in: cancelBag)
        
        contentViewController.saveButton
            .tapPublisher
            .sink { [weak bottomSheetVC] _ in
                bottomSheetVC?.closeBottomSheet()
            }.store(in: cancelBag)
        
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetVC, animated: false, completion: nil)
    }
    
    func showJobPositionBottomSheet() {
        let contentViewController = JobPositionViewController()
        
        let bottomSheetVC = BottomSheetViewController(
            bottomType: .middle,
            contentViewController: contentViewController,
            upScroll: true
        )
        
        contentViewController
            .keywordsPublisher
            .sink { [weak self] keyword in
                self?.positionDatas = keyword
                print("구인 포지션 \(keyword)")
            }.store(in: cancelBag)
        
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetVC, animated: false, completion: nil)
        
    }
    
    private func recruitBind(recruitCount: String) {
        self.rootView.recruitCountLabel.text = recruitCount
    }
}

// MARK: - Network

extension PostViewController {
    private func uploadPost() {
        
        guard let titletext = rootView.postTextView.text else { return }
        guard let descriptiontext = rootView.titleTextField.text else { return }
        
        let requestDto = PostDTO(
            teamMemberNow: 1,
            teamMemberNeed: 3,
            teamTitle: titletext,
            teamUrl: "주소",
            teamIntroduce: descriptiontext,
            teamContent: descriptiontext,
            teamUntact: true,
            teamStatus: true
        )
        
        // TODO: 서버 연결 (아직 안함)
        
        PostingService().requestPostData(data: requestDto)
            .catch { error -> AnyPublisher<Void, Error> in
                print("Error sending user info: \(error)")
                return Fail(error: error).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}
