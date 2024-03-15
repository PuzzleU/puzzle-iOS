//
//  NetworkingError.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 3/15/24.
//

import Foundation

public enum NetworkServiceError: Int, Error {
    
    //Client Error
    
    case badRequest = 400
    case unauthorized = 401
    case forBidden = 403
    case notFound = 404
    
    //Server Error
    
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
}
