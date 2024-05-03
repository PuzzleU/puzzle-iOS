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
    private let viewModel: HomeDetailViewModel
    private var cancelBag = CancelBag()
    
    // MARK: - Life Cycles
    
    init(viewModel: HomeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = HomeDetailViewModel.Input(
            backButtonTapped: rootView.homeDetailHeaderView.homeDetailBackButton.tapPublisher,
            websiteButtonTapped: rootView.homeDetailHeaderView.homeDetailWebsiteButton.tapPublisher,
            shareButtonTapped: rootView.homeDetailHeaderView.homeDetailShareButton.tapPublisher,
            deleteButtonTapped: rootView.homeDetailHeaderView.homeDetailDeleteButton.tapPublisher,
            heartButtonTapped: rootView.homeDetailHeaderView.homeDetailHeartButton.tapPublisher,
            readingglassesButtonTapped: rootView.homeDetailHeaderView.homeDetailReadingglassesButton.tapPublisher
        )
        
        let output = self.viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.backButtonAction
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                //dismiss
            })
            .store(in: cancelBag)
    }
}
