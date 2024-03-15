//
//  Networking.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 3/15/24.
//

import Foundation

protocol Networking {
    func makeHTTPRequest(method: HTTPMethod,
                         baseURL: String,
                         path: String,
                         queryItem: [URLQueryItem],
                         headers: [String: String]?,
                         body: Data?) throws -> URLRequest
}
