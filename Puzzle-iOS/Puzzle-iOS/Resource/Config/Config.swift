//
//  Config.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/5/24.
//

import Foundation

enum Config {    
    static let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as! String
    static let kakaoNativeAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APPKEY"] as! String
}
