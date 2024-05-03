//
//  PostRepository.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/30/24.
//

import Foundation
import Combine

protocol PostRepository {
//    func postData() -> AnyPublisher<SplashDTO, Error>
}

struct DefaultPostRepository: PostRepository {

    private var postService: PostService

    init(postService: PostService) {
        self.postService = postService
    }
//    func postData() -> AnyPublisher<SplashDTO, Error> {
//        
//    }
    
}
