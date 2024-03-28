//
//  DummyData.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/3/24.
//

import UIKit

// TODO: 이 부분을 Dummy로 빼기는 했는데 어떻게 모아놓을지 이야기 해보아야합니당 !

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
               color: .puzzleWhite)
]

let animalProfile = ["imgMouse", "imgFox", "imgDog", "imgTiger", "imgOx", "imgLion", "imgPanda", "imgMonkey", "imgRabbit", "imgBear", "imgCat", "imgRobot"]

let positionImage = ["imgDevelop", "imgPM", "imgMarketing", "imgDesign", "imgData", "imgMiscellaneous"]
