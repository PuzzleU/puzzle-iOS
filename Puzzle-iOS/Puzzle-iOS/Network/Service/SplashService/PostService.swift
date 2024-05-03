//
//  PostService.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/30/24.
//

import Foundation
import Combine

protocol PostService {
    func requestPostData(data: PostDTO) -> AnyPublisher<Void, Error>
}

final class PostingService: NSObject, Networking, PostService {
    
    func requestPostData(data: PostDTO) -> AnyPublisher<Void, Error> {
        do {
            let body = try JSONEncoder().encode(data)
            let request = try makeHTTPRequest(
                path: URLs.Post.team,
                method: .post,
                headers: APIConstants.noTokenHeader,
                body: body
            )
            
            NetworkLogger.log(request: request)
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map { _ in () }
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
            
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
