//
//  HomeDetailViewController.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 4/30/24.
//
import UIKit
import Combine

final class HomeDetailViewController: UIViewController {
    
    // MARK: - UI Component
    
    private let rootView = HomeDetailView()
    private let viewModel: HomeDetailViewModel
    private let competitionId: Int
    private var cancelBag = CancelBag()
    
    private let viewWillAppearEvent = CurrentValueSubject<Int, Never>(12)
    
    // MARK: - Life Cycles
    
    init(viewModel: HomeDetailViewModel, competitionId: Int) {
        self.viewModel = viewModel
        self.competitionId = competitionId
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppearEvent.send(self.competitionId)
    }
    
    private func bindViewModel() {
        let input = HomeDetailViewModel.Input(
            viewWillAppear: viewWillAppearEvent.eraseToAnyPublisher(),
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
