//
//  ViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 1/25/24.
//

import UIKit

import Combine
import SnapKit

class ViewController: UIViewController {
    
    private let repository: SplashRepository
    private var cancelBag = CancelBag()
    
    // MARK: - Life Cycles
    
    init(repository: SplashRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .puzzleWhite
        
        fetchLoginData()
    }
    
    func fetchLoginData() {
        self.repository.getLoginData()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { result in
                print(result)
            })
            .store(in: cancelBag)
    }
}

