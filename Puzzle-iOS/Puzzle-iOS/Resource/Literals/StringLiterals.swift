//
//  StringLiterals.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/6/24.
//

import Foundation

enum StringLiterals {
    enum Login {
        static let title = "같은 목표를 향해 함께\n달려나갈 팀원을 찾으세요."
        static let login = "로그인"
    }
    
    enum Onboarding {
        static let complete = "항목 저장"
        static let next = "다음"
        static let area = "지역"
        static let inputName = "이름을 입력해주세요!"
        static let inputId = "아이디를 입력해주세요. (최대 20자)"
        static let recommededLabel = "인스타그램 아이디를 사용하면 친구들이 찾기 쉬워요!"
        static let recommededLabelSpecial = "인스타그램 아이디"
        static let selectAnimalProfile = "내 프로필로 만들고 싶은 동물을 하나 선택해주세요."
        static let selectAnimalProfileSpecial = "내 프로필"
        static let selectPosition = "포지션에 맞는 공모전을 추천해드려요.\n(최대 2개까지 선택 가능)"
        static let selectPositionSpecial = "공모전"
        static let selectInterest = "관심 분야에 맞는 활동을 추천해드려요."
        static let selectInterestSpecial = "활동"
        static let selectArea = "최대 2개의 지역을 선택할 수 있어요."
        static let selectAreaSpecial = "최대 2개"
    }
    
    enum MyProfile {
        static let bestExperience = "🥇 대표경험"
        static let bestExperienceDetail = "+ 대표경험 서술"
        static let workExperience = "💼 경험 했어요"
        static let workExperienceDetail = "+ 경력 입력"
        static let skillSet = "📌 스킬 셋"
        static let skillSetDetail = "+ 전문분야·스킬 등록"
        static let education = "🎓 학력"
        static let educationDetail = "+ 학교, 전공, 기간 등 입력"
    }
    
    enum Setting {
        static let SettingViewTitle = "설정"
        
        static let guideHeaderTitle = "안내"
        static let personalSettingHeaderTitle = "사용자 설정"
        static let accountHeaderTitle = "계정"
        private static var version: String {
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        }
        static let appInfoHeaderTitle = "현재 버전 \(version)"
        
        static let guideSectionTitles = ["공지사항", "자주 묻는 질문", "고객센터"]
        static let personalSettingSectionTitle = "알림 설정"
        static let accountSectionTitle = "로그아웃"
        static let appInfoSectionTitles = ["개인정보 처리방침", "이용약관"]
        
        static let accountDeletionTitle = "회원 탈퇴"
    }
    
    enum Post {
        static let textFieldPlaceholderLabel = "제목을 입력해 주세요"
        static let textViewPlaceholderLabel =
        """
        같이 하고 싶은 팀원에 대해 자유롭게 설명해주세요!
        [예시]
        (스킬셋) 특히 포토샵을 잘 다루는 분이면 좋겠어요
        (경험) 공모전 수상 경험이 있는 분이면 좋겠어요
        (경험) 경험이 많지 않아도 같이 개발하며 성장할 수 있는 분이면 좋겠어요
        (지역) 대면 가능한 분만 원해요
        """
        
        static let competitionSelectionViewLabel = "공모전 선택"
        static let recruitCountViewLabel = "모집 인원 수"
        static let selectPositionViewLabel = "구인 포지션"
        static let postSaveButtonLabel = "항목 저장"
    }
}
