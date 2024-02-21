//
//  InterestViewModel.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/18/24.
//

import Combine

class InterestViewModel {
    
    // MARK: - Properties
    
    @Published var competitions: [String] = []
    @Published var jobs: [String] = []
    @Published var studys: [String] = []
    
    let backButtonTapped = PassthroughSubject<Void, Never>()
    
    init() {
        loadDatas()
    }
    
    private func loadDatas() {
        let competition = ["기획", "마케팅", "네이밍", "디자인", "개발", "아주 긴 데이터 어떤데 ㅋㄱ", "미디어"]
        let job = ["iOS", "전략 기획", "안드로이드", "갓 생 살아라"]
        let study = ["언어", "경제/시사 이건 거의 1줄", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사", "취업", "독서", "경제/시사"]
        competitions = competition.compactMap { $0 }
        jobs = job.compactMap { $0 }
        studys = study.compactMap { $0 }
    }
}
