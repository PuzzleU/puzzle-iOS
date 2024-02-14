//
//  UIViewController+.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/7/24.
//

import UIKit

import SnapKit
import Then

@frozen
enum DropDownLayout: String {
    case leading
    case trailing
}

extension UIViewController {
    
    func pushToViewController() {
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// 뷰 컨트롤러가 네비게이션 스택에 있으면 pop 하고, 나머지는  dismiss 합니다.
    func popOrDismissViewController(animated: Bool = true) {
        if let navigationController = self.navigationController, navigationController.viewControllers.contains(self) {
            navigationController.popViewController(animated: animated)
        } else if self.presentingViewController != nil {
            self.dismiss(animated: animated)
        }
    }
    
    func showToast(message: String, heightOffset: CGFloat? = nil) {
        let height = heightOffset ?? 233 // default 값
        
        PuzzleToastView.show(
            message: message,
            view: self.view,
            safeAreaBottomInset: self.safeAreaBottomInset(),
            height: height
        )
    }
    
    private func safeAreaBottomInset() -> CGFloat {
        return view.safeAreaInsets.bottom
    }
    
    /// mainView 는 PuzzleDropdownView(title: Stirng) 꼴로 선언
    func makeDropdown(mainView: PuzzleDropdownView, dropdownViewSize: CGSize, dropdownViewLayout: DropDownLayout, dropdownData: [String]) {
        
        let dropdownView = PuzzleDropdownTableView()
        dropdownView.dropdownData = dropdownData
        dropdownView.tag = dropdownViewTag
        dropdownView.isHidden = true
        
        self.view.addSubview(dropdownView)
        dropdownView.snp.makeConstraints {
            $0.top.equalTo(mainView.snp.bottom)
            $0.width.equalTo(dropdownViewSize.width)
            $0.height.equalTo(dropdownViewSize.height)
            
            if dropdownViewLayout.rawValue == "leading" {
                $0.leading.equalTo(mainView.snp.leading)
            } else {
                $0.trailing.equalTo(mainView.snp.trailing)
            }
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dropdownTapped))
        mainView.addGestureRecognizer(tapGesture)
    }
    
    private var dropdownViewTag: Int {
        return 999
    }
    
    @objc
    private func dropdownTapped(_ sender: UITapGestureRecognizer) {
        guard let dropdownView = self.view.viewWithTag(dropdownViewTag) as? PuzzleDropdownTableView else {
            return
        }
        dropdownView.isHidden.toggle()
    }
}
