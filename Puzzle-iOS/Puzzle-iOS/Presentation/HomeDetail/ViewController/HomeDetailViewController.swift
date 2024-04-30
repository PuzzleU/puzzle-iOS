//
//  HomeDetailViewController.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 4/30/24.
//
import UIKit
import Combine

final class HomeDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let rootView = HomeDetailView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
    }
}
