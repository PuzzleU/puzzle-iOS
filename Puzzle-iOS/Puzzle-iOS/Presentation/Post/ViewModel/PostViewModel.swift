//
//  PostViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/19/24.
//

import Foundation
import Combine

class PostViewModel: ViewModelType {
    
    var cancelBag = CancelBag()
    
    struct Input {
        let postTextViewDidChange: AnyPublisher<String, Never>
        let postTextBeginEditingChange: AnyPublisher<Void, Never>
        let postTextEndEditingChange: AnyPublisher<Void, Never>
        let didUploadTapped: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let postTextViewText: AnyPublisher<String, Never>
        let postTextViewBeginEditingChange: AnyPublisher<Void, Never>
        let postTextEndEditingChange: AnyPublisher<Void, Never>
        let didUploadPosting: AnyPublisher<Void, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let postTextViewDidChange = input.postTextViewDidChange
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
        let postTextBeginEditingChange = input.postTextBeginEditingChange
            .receive(on: RunLoop.main)
            .print()
            .eraseToAnyPublisher()
        
        let postTextEndEditingChange = input.postTextEndEditingChange
            .receive(on: RunLoop.main)
            .print()
            .eraseToAnyPublisher()
        
        let didUploadPosting = input.didUploadTapped
            .receive(on: RunLoop.main)
            .print()
            .eraseToAnyPublisher()
        //            .flatMap { _ in
        //                self.uploadPostToServer()
        //                    .receive(on: RunLoop.main)
        //                    .eraseToAnyPublisher()
        //            }
        //            .share()
        //            .eraseToAnyPublisher()
        
        return Output(
            postTextViewText: postTextViewDidChange,
            postTextViewBeginEditingChange: postTextBeginEditingChange,
            postTextEndEditingChange: postTextEndEditingChange,
            didUploadPosting: didUploadPosting
        )
    }
    
    //    private func uploadPostToServer() -> AnyPublisher<PostDTO, Error> {
    //
    //    }
}
