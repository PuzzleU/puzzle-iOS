//
//  PostDTO.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/30/24.
//

import Foundation

struct PostDTO: Codable {
    let teamMemberNow, teamMemberNeed: Int
    let teamTitle, teamUrl, teamIntroduce, teamContent: String
    let teamUntact, teamStatus: Bool
}
