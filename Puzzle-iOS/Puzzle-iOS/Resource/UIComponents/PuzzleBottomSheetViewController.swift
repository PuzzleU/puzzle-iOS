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

@frozen
enum PuzzleBottomSheetType {
    case high, low
    
    var height: Double {
        switch self {
        case .high:
            return UIScreen.main.bounds.height * 0.86
        case .low:
            return 0
        }
    }
}

final class PuzzleBottomSheetViewController: UIViewController {

    // MARK: - Properties
    
    @Published private var bottomSheetShown = false
    private var cancelBag = CancelBag()
    private var bottomHeight = 700.0
    
    // MARK: - UI Components
    
    private var insertView = UIView()
    private let dimmedView = UIView()
    private let bottomSheetView = UIView().then {
        $0.backgroundColor = .puzzleWhite
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
    }
    private lazy var completeButton = PuzzleMainButton(title: StringLiterals.Onboarding.complete)
    private lazy var cancelButton = UIButton().then {
        $0.setImage(UIImage.icCancel, for: .normal)
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
    
    // MARK: - UI & Layout

    private func setHierarchy() {
        self.view.addSubviews(dimmedView, bottomSheetView)
        bottomSheetView.addSubviews(insertView, completeButton, cancelButton)
    }
    
    private func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        insertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
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
                self.dimmedView.backgroundColor = .puzzleDimmed
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
    
    private func setDismissAction() {
        cancelButton.addTarget(self, action: #selector(dismissBottomSheet), for: .touchUpInside)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissBottomSheet))
        swipeGesture.direction = .down
        self.bottomSheetView.addGestureRecognizer(swipeGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissBottomSheet))
        self.dimmedView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissBottomSheetByPanGesture))
        bottomSheetView.addGestureRecognizer(panGesture)
    }
    
    @objc
    private func dismissBottomSheet() {
        bottomSheetShown = false
    }
    
    @objc
    private func dismissBottomSheetByPanGesture(_ sender: UIPanGestureRecognizer) {
        let viewTranslation = sender.translation(in: view)
        let viewVelocity = sender.translation(in: view)
        
        switch sender.state {
        case .changed:
            if abs(viewVelocity.y) > abs(viewVelocity.x) {
                if viewVelocity.y > 0 && viewVelocity.y < 250 {
                    self.dimmedView.backgroundColor = .clear
                    UIView.animate(withDuration: 0.1, animations: {
                        self.view.transform = CGAffineTransform(translationX: 0, y: viewTranslation.y)
                    })
                } else {
                    bottomSheetShown = false
                }
            }
            
        case .ended:
            if viewTranslation.y < 250 {
                UIView.animate(withDuration: 0.1, animations: {
                    self.view.transform = .identity
                })
            } else {
                bottomSheetShown = false
            }
            
        default:
            break
        }
    }
}
