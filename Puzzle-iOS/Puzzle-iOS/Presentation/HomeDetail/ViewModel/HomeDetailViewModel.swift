//
//  File.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 4/30/24.
//


import Foundation
import UIKit
import Combine

final class HomeDetailViewModel: ViewModelType {
    
    // MARK: - Properties
    
    private let homeDetailService: HomeDetailService
    var cancelBag = CancelBag()
    
    struct Input {
        let viewWillAppear: AnyPublisher<Int, Never>
        let backButtonTapped : AnyPublisher<Void, Never>
        let websiteButtonTapped: AnyPublisher<Void, Never>
        let shareButtonTapped: AnyPublisher<Void, Never>
        let deleteButtonTapped: AnyPublisher<Void, Never>
        let heartButtonTapped: AnyPublisher<Void, Never>
        let readingglassesButtonTapped: AnyPublisher<Void, Never>
    }
    
    struct Output {
        var backButtonAction = CurrentValueSubject<Bool, Never>(false)
        var shareButtonAction = CurrentValueSubject<Bool, Never>(false)
        var deleteButtonAction = CurrentValueSubject<Bool, Never>(false)
        var heartButtonAction = CurrentValueSubject<Bool, Never>(false)
        let readingglassesButtonAction = CurrentValueSubject<Bool, Never>(false)
    }
    
    // MARK: - init
    
    init(homeDetailService: HomeDetailService) {
        self.homeDetailService = homeDetailService
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        
        var output = Output()
        
        input.viewWillAppear
            .flatMap { competitionId -> AnyPublisher<HomeDetailDTO, Error> in
                self.getCompetitionDetail(competitionId: competitionId)
            }
            .catch { error -> AnyPublisher<HomeDetailDTO, Error> in
                print("Error sending user info: \(error)")
                return Fail(error: error).eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Competition detail received successfully.")
                case .failure(let error):
                    print("Error receiving competition detail: \(error)")
                }
            }, receiveValue: { homeDetailDTO in
                print("Received HomeDetailDTO: \(homeDetailDTO)")
            })
            .store(in: &cancelBag.subscriptions)
        
        input.backButtonTapped
            .map { true }
            .subscribe(output.backButtonAction)
            .store(in: &cancelBag.subscriptions)
        
        input.websiteButtonTapped
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                if let url = URL(string: "https://www.naver.com") {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            .store(in: &cancelBag.subscriptions)
        
        input.shareButtonTapped
            .map { true }
            .subscribe(output.shareButtonAction)
            .store(in: &cancelBag.subscriptions)
        
        input.deleteButtonTapped
            .map { true }
            .subscribe(output.deleteButtonAction)
            .store(in: &cancelBag.subscriptions)
        
        input.heartButtonTapped
            .map { true }
            .subscribe(output.heartButtonAction)
            .store(in: &cancelBag.subscriptions)
        
        input.readingglassesButtonTapped
            .map { true }
            .subscribe(output.readingglassesButtonAction)
            .store(in: &cancelBag.subscriptions)
        
        return output
    }
    
    private func getCompetitionDetail(competitionId: Int) -> AnyPublisher<HomeDetailDTO, Error> {
        homeDetailService.getCompetitionDetailData(competitionID: competitionId)
            .map { $0 }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

