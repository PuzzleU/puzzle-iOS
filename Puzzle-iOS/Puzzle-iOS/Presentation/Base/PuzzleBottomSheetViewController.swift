//
//  PuzzleBottomSheetViewController.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/9/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class PuzzleBottomSheetViewController: UIViewController {

    // MARK: - Properties
    
    @Published private var bottomSheetShown = false
    private var cancelBag = CancelBag()
    private var bottomHeight = 700.0
    
    // MARK: - UI Components
    
    private var insertView = UIView()
    private let dimmedView = UIView()
    private let bottomSheetView = UIView().then {
        $0.backgroundColor = .puzzleRealWhite
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
    }
    private lazy var completeButton = PuzzleMainButton(title: StringLiterals.Onboarding.complete)
    private lazy var cancelButton = UIButton().then {
        $0.setImage(UIImage.cancel, for: .normal)
    }
    
    // MARK: - Life Cycles
    
    init(bottomType: PuzzleBottomSheetType,
         insertView: UIView) {
        super.init(nibName: nil, bundle: nil)
        
        self.bottomHeight = bottomType.height
        self.insertView = insertView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setHierarchy()
        setLayout()
        setPublisher()
        setDismissAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bottomSheetShown = true
    }
    
    // MARK: - UI methods

    private func setHierarchy() {
        [dimmedView, bottomSheetView].forEach {
            self.view.addSubview($0)
        }
        [insertView, completeButton, cancelButton].forEach {
            bottomSheetView.addSubview($0)
        }
    }
    
    private func setLayout() {
        dimmedView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints() {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        insertView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints() {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(25)
        }
    }
    
    // MARK: - Publish methods
    
    private func setPublisher() {
        $bottomSheetShown
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shown in
                self?.updateBottomSheetUI(shown: shown)
            }
            .store(in: cancelBag)
    }
}

// MARK: - Update BottomSheet UI

extension PuzzleBottomSheetViewController {
    private func updateBottomSheetUI(shown: Bool) {
        /// bottomSheet 표출
        if shown {
            bottomSheetView.snp.remakeConstraints {
                $0.bottom.leading.trailing.equalToSuperview()
                $0.top.equalToSuperview().inset(self.view.frame.height - bottomHeight)
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.dimmedView.backgroundColor = .black.withAlphaComponent(0.5)
                self.view.layoutIfNeeded()
            }
        } 
        
        /// bottomSheet 제거
        else {
            bottomSheetView.snp.remakeConstraints {
                $0.bottom.leading.trailing.equalToSuperview()
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.dimmedView.backgroundColor = .clear
                self.view.layoutIfNeeded()
            }, completion: { _ in 
                if self.presentingViewController != nil {
                    self.dismiss(animated: true)
                }
            })
        }
    }
    
    @objc
    private func dismissBottomSheet() {
        bottomSheetShown = false
    }
    
    private func setDismissAction() {
        cancelButton.addTarget(self, action: #selector(dismissBottomSheet), for: .touchUpInside)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissBottomSheet))
        swipeGesture.direction = .down
        self.bottomSheetView.addGestureRecognizer(swipeGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissBottomSheet))
        self.dimmedView.addGestureRecognizer(tapGesture)
    }
}
