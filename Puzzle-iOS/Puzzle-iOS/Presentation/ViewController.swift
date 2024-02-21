//
//  ViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 1/25/24.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    var testButton = PuzzleMainButton(title: "테스트버튼임")
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        testButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        self.view.addSubview(testButton)
    }
    
    @objc func test() {
        let viewController = PuzzleBottomSheetViewController(bottomType: .high, insertView: LoginView())
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
}

