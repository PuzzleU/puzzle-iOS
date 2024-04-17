//
//  UserInfoDTO.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/16/24.
//

struct UserInfoDTO: Codable {
    var userKoreaName: String?
    var userPuzzleId: String?
    var userProfileId: Int?
    var userPositionIDs: [Int]?
    var userInterestIdList: [Int]?
    var userLocationIdList: [Int]?
}
