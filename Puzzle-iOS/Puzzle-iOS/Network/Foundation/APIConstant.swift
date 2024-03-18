//
//  APIConstant.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 3/15/24.
//

import Foundation

struct APIConstants {
    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    static let multipartFormData = "multipart/form"
    static let auth = "Authorization"
    static let refresh = "RefreshToken"
    static let fcm = "FcmToken"

    static let boundary = "Boundary-\(UUID().uuidString)"
}

extension APIConstants {
    static var noTokenHeader: Dictionary<String, String> {
        [contentType: applicationJSON]
    }
}
