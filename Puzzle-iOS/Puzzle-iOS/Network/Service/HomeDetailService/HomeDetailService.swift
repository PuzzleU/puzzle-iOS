//
//  HomeDetailService.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 5/3/24.
//

import Foundation
import Combine

protocol HomeDetailService {
    func getCompetitionDetailData(competitionID: Int) -> AnyPublisher<HomeDetailDTO, Error>
}

final class HomeDetailDefalutService: NSObject, Networking, HomeDetailService {
    func getCompetitionDetailData(competitionID: Int) -> AnyPublisher<HomeDetailDTO, Error> {
        do {
            let competitionQueryItems: [URLQueryItem] = 
            [URLQueryItem(name: "competitionId", value: String(describing: competitionID))]
            let request = try makeHTTPRequest(path: URLs.Home.detail,
                                              method: .get,
                                              queryItems: competitionQueryItems,
                                              headers: APIConstants.noTokenHeader,
                                              body: nil)
            NetworkLogger.log(request: request)
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: HomeDetailDTO.self, decoder: JSONDecoder())
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
            
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
