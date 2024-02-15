//
//  DropdownManger.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/15/24.
//

import UIKit
import Combine

import SnapKit
import Then

@frozen
enum DropDownLayout: String {
    case leading
    case trailing
}

class DropdownManager {
    
    // MARK: - Properties
    
    static let shared = DropdownManager()
    private init() {}
    
    // MARK: - UI Components
    
    private var dropdowns: [UIView : PuzzleDropdownTableView] = [:]
    
    // MARK: - Create Dropdown
    
    func createDropdown(mainView: PuzzleDropdownView, viewController: UIViewController, dropboxSize: CGSize, dropdownAlign: DropDownLayout, dropboxData: [String]) {
        guard dropdowns[mainView] == nil else { return }
        
        let dropdownView = PuzzleDropdownTableView()
        dropdownView.dropdownData = dropboxData
        dropdownView.isHidden = true
        
        viewController.view.addSubview(dropdownView)
        dropdownView.snp.makeConstraints {
            $0.top.equalTo(mainView.snp.bottom)
            $0.width.equalTo(dropboxSize.width)
            
            if dropdownAlign.rawValue == "leading" {
                $0.leading.equalTo(mainView.snp.leading)
            } else {
                $0.trailing.equalTo(mainView.snp.trailing)
            }
            
            let calculateHeight = CGFloat(dropboxData.count * NumberLiterals.DropDown.dropDownHeight)
            let resetHeight = calculateHeight < dropboxSize.height ? calculateHeight : dropboxSize.height
            $0.height.equalTo(resetHeight)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dropdownTapped(_:)))
        mainView.addGestureRecognizer(tapGesture)
        
        dropdowns[mainView] = dropdownView
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("updatePuzzleDropdownTitle"), object: dropdownView, queue: nil) { notification in
            if let title = notification.userInfo?["title"] as? String {
                mainView.bindTitle(title: title)
            }
            dropdownView.isHidden.toggle()
        }
    }
    
    @objc
    private func dropdownTapped(_ sender: UITapGestureRecognizer) {
        guard let mainView = sender.view, let dropdownView = dropdowns[mainView] else { return }
        dropdownView.isHidden.toggle()
    }
}

