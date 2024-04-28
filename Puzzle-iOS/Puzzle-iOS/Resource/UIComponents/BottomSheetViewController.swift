//
//  BottomSheetViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/28/24.
//

import UIKit
import Combine

import SnapKit
import Then

enum BottomSheet {
    case expand, middle, low, end
    
    var height: Double {
        switch self {
        case .expand:
            return UIScreen.main.bounds.height * 0.86
        case .middle:
            return UIScreen.main.bounds.height * 0.5
        case .low:
            return UIScreen.main.bounds.height * 0.3
        case .end:
            return 0
        }
    }
}

final class BottomSheetViewController: UIViewController {
    
    
    // MARK: - Property
    
    private lazy var screenHeight = self.view.frame.height
    
    private var bottomHeight: Double = 700.0
    private var cancelBag = CancelBag()
    
    // MARK: - UIComponents
    
    private let dimmedView = UIView().then {
        $0.backgroundColor = .puzzleDimmed
    }
    
    private var bottomSheetView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // MARK: - Life Cycles
    
    init(bottomType: BottomSheet) {
        super.init(nibName: nil, bundle: nil)
        
        self.bottomHeight = bottomType.height
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        showBottomSheet()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        
    }
    
    private func setHierarchy() {
        view.addSubviews(dimmedView, bottomSheetView)
        
        dimmedView.alpha = 0.0
    }
    
    private func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(view.snp.bottom).offset(0)
        }
    }
    
    private func setAddTarget() {
        
        dimmedView.gesture(.tap())
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.hideBottomSheetAndGoBack()
            }.store(in: cancelBag)
        
//        bottomSheetView.gesture(.pan())
//            .receive(on: RunLoop.main)
//            .sink { [weak self] gesture in
//                switch gesture {
//                case .pan(let panGesture):
//                    self?.handlePanGesture(sender: panGesture)
//                    print("Gesture State: \(panGesture.state.rawValue)")
//                default:
//                    break
//                }
//            }
//            .store(in: cancelBag)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(sender:)))
        bottomSheetView.addGestureRecognizer(panGesture)
        
    }
    
    private func showBottomSheet() {
        
        bottomSheetView.snp.remakeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().inset(screenHeight - bottomHeight)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.dimmedView.alpha = 0.7
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideBottomSheetAndGoBack() {
        
        bottomSheetView.snp.remakeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().inset(screenHeight)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        } completion: { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @objc
    private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
//        print("Gesture State: \(sender.state.rawValue)")
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .changed:
            // 현재 바텀 시트의 top 위치를 계산
            let newTop = max(0, bottomSheetView.frame.origin.y + translation.y)
            
            // 바텀 시트의 위치를 업데이트
            bottomSheetView.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(newTop)
            }
            view.layoutIfNeeded() // 즉시 레이아웃 업데이트

            sender.setTranslation(CGPoint.zero, in: view) // 드래그 위치 초기화

        case .ended, .cancelled:
            print("끝")
            // 드래그 종료 후 가장 가까운 위치로 스냅
            snapBottomSheetToNearestPosition()
        default:
            break
        }
    }

    private func snapBottomSheetToNearestPosition() {
        // 계산된 각 위치를 배열로 저장
        let positions = [
            screenHeight * 0.86,  // expand
            screenHeight * 0.5,   // middle
            screenHeight * 0.3,   // low
            0                     // end
        ]
        
        let currentTop = bottomSheetView.frame.minY
        let closestPosition = positions.min(by: { abs($0 - currentTop) < abs($1 - currentTop) })!
        
        // 최종 위치로 애니메이션
        bottomSheetView.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(closestPosition)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }

}
