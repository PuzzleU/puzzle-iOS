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
               color: .white)
]

let animalProfile = ["imgMouse", "imgFox", "imgDog", "imgTiger", "imgOx", "imgLion", "imgPanda", "imgMonkey", "imgRabbit", "imgBear", "imgCat", "imgRobot"]

let positionImage = ["imgDevelop", "imgPM", "imgMarketing", "imgDesign", "imgData", "imgMiscellaneous"]

let interest = Interest(competition: ["기획", "마케팅", "네이밍", "디자인", "개발", "아주 긴 데이터 어떤데 ㅋㄱ", "미디어"],
                        job: ["iOS", "전략 기획", "안드로이드", "갓 생 살아라"],
                        study: ["언어", "경제/시사 이건 거의 1줄", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사"])
