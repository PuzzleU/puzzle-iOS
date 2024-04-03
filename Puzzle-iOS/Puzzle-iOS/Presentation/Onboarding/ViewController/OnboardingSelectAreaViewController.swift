//
//  OnboardingSelectAreaViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/18/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class OnboardingSelectAreaViewController: UIViewController {
    
    // MARK: - Properties
    
    private let rootView = OnboardingBaseView()
    private let areaTableView = AreaTableView()
    
    private var viewModel: AreaViewModel
    private var cancelBag = CancelBag()
    
    let showBottomSheetSubject = PassthroughSubject<Void, Never>()
    
    private var areaLists: [Area] = []
    
    private let locationTapSubject: PassthroughSubject<Int, Never> = .init()
    var locationTapPublisher: AnyPublisher<Int, Never> {
        return locationTapSubject.eraseToAnyPublisher()
    }
    
    private lazy var puzzleBottomSheet = PuzzleBottomSheetViewController(bottomType: .high, insertView: areaTableView)
    
    // MARK: - UI Components
    
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("활동 가능 지역을 선택해주세요")
    
    private let activityAreaSelectView = UIView().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.puzzleGray300.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let locationImage = UIImageView().then {
        $0.image = UIImage(resource: .icLocation)
    }
    
    private let activityAreaSelectLabel = UILabel().then {
        $0.text = "자주 활동하는 지역을 검색해주세요."
        $0.font = .body3
        $0.textColor = .puzzleBlack
    }
    
    private let alertLabel = UILabel().then {
        let label = StringLiterals.Onboarding.selectArea
        let specialCharacter = StringLiterals.Onboarding.selectAreaSpecial
        
        $0.highlightSpecialText(
            mainText: label,
            specialTexts: [specialCharacter],
            mainAttributes: [
                .font: UIFont.subTitle3,
                .foregroundColor: UIColor.black
            ],
            specialAttributes: [
                .font: UIFont.subTitle3,
                .foregroundColor: UIColor.puzzlePurple
            ]
        )
        $0.numberOfLines = 0
    }
    
    // MARK: - Life Cycles
    
    init(viewModel: AreaViewModel) {
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
        
        setHierarchy()
        setLayout()
        setNaviBindings()
        setBindings()
        observe()
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        view.addSubviews(
            naviBar,
            activityAreaSelectView,
            locationImage,
            activityAreaSelectLabel,
            alertLabel
        )
    }
    
    private func setLayout() {
        naviBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8 + 5)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        activityAreaSelectView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(27)
            $0.height.equalTo(32)
        }
        
        locationImage.snp.makeConstraints {
            $0.leading.equalTo(activityAreaSelectView.snp.leading).inset(11)
            $0.centerY.equalTo(activityAreaSelectView)
        }
        
        activityAreaSelectLabel.snp.makeConstraints {
            $0.leading.equalTo(locationImage.snp.trailing).offset(12.15)
            $0.centerY.equalTo(activityAreaSelectView)
        }
        
        alertLabel.snp.makeConstraints {
            $0.top.equalTo(activityAreaSelectView.snp.bottom).offset(8)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(27)
        }
    }
}

// MARK: - Methods

extension OnboardingSelectAreaViewController {
    private func setNaviBindings() {
        naviBar.resetLeftButtonAction({ [weak self] in
            self?.viewModel.backButtonTapped.send()
        }, .leftTitleWithLeftButton)
    }
    
    private func setBindings() {
        
        let input = AreaViewModel.Input(
            viewDidLoad: self.viewDidLoadPublisher,
            LocationTapPublisher: self.locationTapPublisher
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.locationListPublisher.sink(receiveCompletion: { completion in
            print("completion = \(completion)")
        }, receiveValue: { [weak self] value in
            self?.areaLists = value
            self?.areaTableView.bind(areaData: value.map {$0.name})
            print("🍎 정제한 데이터? value= \(value.map { $0.name })")
        }).store(in: cancelBag)
        
        // 활동하는 지역 View 탭 제스처 퍼블리셔
        activityAreaSelectView.gesture(.tap())
            .sink { [weak self] _ in
                self?.showBottomSheetSubject.send()
                self?.presentBottomSheet()
            }
            .store(in: cancelBag)
        
    }
    
    private func observe() {
        rootView.nextButtonTapped.sink { [weak self] _ in
            self?.viewModel.nextButtonTapped.send()
        }.store(in: cancelBag)
    }
    
    private func presentBottomSheet() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, self.isViewLoaded && self.view.window != nil else {
                return
            }
            
            let bottomSheetVC = self.puzzleBottomSheet
            bottomSheetVC.modalPresentationStyle = .overFullScreen
            self.present(bottomSheetVC, animated: false, completion: nil)
            bottomSheetVC.updateInsertView()
        }
    }
}
