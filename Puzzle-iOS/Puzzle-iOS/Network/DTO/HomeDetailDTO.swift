//
//  HomeDetailDTO.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 5/3/24.
//

import Foundation

struct HomeDetailDTO: Codable {
    let success: Bool
    let response: CompetitionDetail?
    let error: String?
    let jwt: String?
}

struct CompetitionDetail: Codable {
    let competitionId: Int
    let competitionName: String
    let competitionUrl: String
    let competitionHost: String
    let competitionPoster: String
    let competitionAwards: String
    let competitionStart: String
    let competitionEnd: String
    let competitionContent: String
    let competitionVisit: Int
    let competitionLike: Int
    let competitionMatching: Int
    let competitionDDay: Int
    let competitionTypes: [String]
}
