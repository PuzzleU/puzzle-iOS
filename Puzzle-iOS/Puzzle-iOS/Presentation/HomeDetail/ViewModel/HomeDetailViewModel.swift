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
    
    var cancelBag = CancelBag()
    
    struct Input {
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
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        var output = Output()
        
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
}

