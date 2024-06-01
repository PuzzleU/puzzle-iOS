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
    
    private let postRepository: PostRepository
    
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
    
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
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
            .flatMap { [weak self] _ -> AnyPublisher<Void, Never> in
                guard let self = self else { return Just(()).eraseToAnyPublisher() }
                return self.postRepository.postData()
                    .catch { _ in Just(()) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        
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
