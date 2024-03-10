//
//  AuthDTO.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/1/24.
//

import Foundation

// TODO: API명세서 나온 뒤 수정 예정

struct AuthRequestDTO: Encodable {
    let socialPlatform: String
}

struct AuthLoginResponseDTO: Decodable {
    let nickName: String
    let accessToken, refreshToken: String
}
