//
//  PostRepository.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/30/24.
//

import Foundation
import Combine

protocol PostRepository {
    func postData() -> AnyPublisher<Void, Never>/* -> AnyPublisher<SplashDTO, Never>*/
}

struct DefaultPostRepository: PostRepository {

    private var postService: PostService

    init(postService: PostService) {
        self.postService = postService
    }
    func postData() -> AnyPublisher<Void, Never> {
        return Just(print("서버 통신")).eraseToAnyPublisher()
    }
    
}
