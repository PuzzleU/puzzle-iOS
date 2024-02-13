//
//  OnboardingViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/13/24.
//

import UIKit
import Combine

import Then
import SnapKit

class OnboardingViewController: UIPageViewController {

    // MARK: - Properties
    
    private let rootView = OnboardingView()

    private var cancelBag = CancelBag()
    var viewModel: OnboardingViewModel!
    
    
    // MARK: - UI Conponents

    private let inputId = UITextField().then {
        $0.placeholder = "아이디를 입력해주세요"
    }
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setBindings()
    }
    
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.addSubview(inputId)
    }
    
    private func setLayout() {
        
        inputId.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
    }
    
    private func setBindings() {
        
        viewModel = OnboardingViewModel()
        
        inputId.textPublisher
            .print()
            .receive(on: DispatchQueue.main)
            .assign(to: \.textFieldOnboarding, on: viewModel)
            .store(in: cancelBag)
    }

}

// UITextField의 text 변화를 감지하는 Publisher 확장
extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}
