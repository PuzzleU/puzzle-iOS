//
//  NetworkingError.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 3/15/24.
//

import Foundation

enum NetworkError: Int, Error, CustomStringConvertible {

    public var description: String { self.errorDescription }
    
    //Client Error
    
    case badURL = 0
    case badRequest = 400
    case unauthorized = 401
    case forBidden = 403
    case notFound = 404
    
    //Server Error
    
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    
    var errorDescription: String {
        switch self {
        case .badURL: return "BadUrl"
        case .badRequest: return "BadRequest"
        case .unauthorized: return "Unauthorized"
        case .forBidden: return "ForBidden"
        case .notFound: return "NotFound"
        case .internalServerError: return "InternalServerError"
        case .notImplemented: return "NotImplemented"
        case .badGateway: return "BadGateway"
        }
    }
}
