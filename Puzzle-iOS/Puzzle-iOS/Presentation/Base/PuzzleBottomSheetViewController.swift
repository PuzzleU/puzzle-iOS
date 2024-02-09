//
//  PuzzleBottomSheetViewController.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/9/24.
//

import UIKit

import SnapKit
import Then

final class PuzzleBottomSheetViewController: UIViewController {

    // MARK: - Properties
    
    private var bottomHeight = 700.0
    
    // MARK: - UI Components
    
    private var insertView = UIView()
    private let dimmedView = UIView()
    private let bottomSheetView = UIView().then {
        $0.backgroundColor = .puzzleRealWhite
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 20
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
}

extension PuzzleBottomSheetViewController {
    func showBottomSheet() {
        
    }
    
    func hideBottomSheet() {
        
    }
}
