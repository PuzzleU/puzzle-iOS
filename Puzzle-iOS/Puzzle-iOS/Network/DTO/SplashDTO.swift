//
//  SplashDTO.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 3/15/24.
//

import Foundation

struct SplashDTO: Codable {
    let success: Bool
    let response: [ResponseList]
    let error: [Error]
}

struct ResponseList: Codable {
    let postionList: [PositionListDetail]
    let interestList: [InterestListDetail]
    let profileList: [ProfileListDetail]
}

struct PositionListDetail: Codable {
    let positionId: Int
    let positionName: String
}

struct InterestListDetail: Codable {
    let interestType: String
    let interestList: [InterestListMoreDetail]
}

struct InterestListMoreDetail: Codable {
    let interestName: String
    let interestId: Int
}

struct ProfileListDetail: Codable {
    let profileId: Int
    let profileUrl: String
}

struct Error: Codable {
    let status: Int
    let message: String
}
