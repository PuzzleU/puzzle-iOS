//
//  DummyData.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/3/24.
//

import UIKit

struct LoginModel {
    let title: String
    let image: UIImage
    let color: UIColor
}

let LoginButtonData = [
    LoginModel(title: "카카오 로그인",
               image: UIImage(named: "heart.fill") ?? UIImage(),
               color: .kakao),
    LoginModel(title: "Apple 로그인",
               image: UIImage(named: "heart.fill") ?? UIImage(),
               color: .white)
]
