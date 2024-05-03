//
//  HomeDetailDescriptionView.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 4/30/24.
//

import UIKit

import SnapKit
import Then

final class HomeDetailDescriptionView: UIView {
    
    // MARK: - UIComponents
    
    private let competitionTitleLabel = UILabel().then {
        $0.text = "제21회 KPR 대학생PR 아이디어 공모전"
        $0.font = .subTitle1
        $0.textColor = .puzzleBlack
        $0.numberOfLines = 2
    }
    private let competitionHostLabel = UILabel().then {
        $0.text = "주)케이피알앤드어소시에이츠(KPR)"
        $0.font = .subTitle3
        $0.textColor = .puzzleBlack
        $0.numberOfLines = 1
    }
    
    private let checkImage = UIImageView().then {
        $0.image = UIImage(resource: .icCheck)
        $0.contentMode = .scaleAspectFit
    }
    private var checkLabel = UILabel().then {
        $0.text = "조회"
        $0.font = .subTitle4
        $0.textColor = .puzzleBlack
        $0.numberOfLines = 1
    }
    
    private let teamImage = UIImageView().then {
        $0.image = UIImage(resource: .icTeam)
        $0.contentMode = .scaleAspectFit
    }
    private var teamLabel = UILabel().then {
        $0.text = "빌딩 중인 팀"
        $0.font = .subTitle4
        $0.textColor = .puzzleBlack
        $0.numberOfLines = 1
    }
    
    private let heartImage = UIImageView().then {
        $0.image = UIImage(resource: .icBlackHeart)
        $0.contentMode = .scaleAspectFit
    }
    private var heartLabel = UILabel().then {
        $0.text = "관심"
        $0.font = .subTitle4
        $0.textColor = .puzzleBlack
        $0.numberOfLines = 1
    }
    
    private let fieldLabel = UILabel().then {
        $0.text = "공모분야"
        $0.font = .body1
        $0.textColor = .puzzleGray800
        $0.numberOfLines = 1
    }
    private let prizeLabel = UILabel().then {
        $0.text = "시상내역"
        $0.font = .body1
        $0.textColor = .puzzleGray800
        $0.numberOfLines = 1
    }
    private let hostLabel = UILabel().then {
        $0.text = "주최/주관"
        $0.font = .body1
        $0.textColor = .puzzleGray800
        $0.numberOfLines = 1
    }
    private let periodLabel = UILabel().then {
        $0.text = "접수기간"
        $0.font = .body1
        $0.textColor = .puzzleGray800
        $0.numberOfLines = 1
    }
    private let descriptionLabel = UILabel().then {
        $0.text = "상세내용"
        $0.font = .body1
        $0.textColor = .puzzleGray800
        $0.numberOfLines = 1
    }
    
    private var fieldInfoLabel = UILabel().then {
        $0.text = "기획, 아이디어"
        $0.font = .body2
        $0.textColor = .puzzleGray800
        $0.numberOfLines = 0
    }
    private var prizeInfoLabel = UILabel().then {
        $0.text = "상금, 1등 (500만원)"
        $0.font = .body2
        $0.textColor = .puzzleGray800
        $0.numberOfLines = 0
    }
    private var hostInfoLabel = UILabel().then {
        $0.text = "케이피알앤드어소시에이츠 (KPR)"
        $0.font = .body2
        $0.textColor = .puzzleGray800
        $0.numberOfLines = 0
    }
    private var periodInfoLabel = UILabel().then {
        $0.text = "2023-11-17 00:00 ~ \n2024-01-15 18:00"
        $0.font = .body2
        $0.textColor = .puzzleGray800
        $0.numberOfLines = 0
    }
    private var descriptionInfoLabel = UILabel().then {
        $0.text = "[행사취지 및 목적] - 국내 PR산업의 발전 도모 - 대학생들의 PR에 대한 관심 제고 및 창의적인 PR 아이디어 발굴 - 빠르게 변화하는 콘텐츠 분야의 우수한 인재 발굴 [주 최]: (주)케이피알앤드어소시에이츠(KPR) [협 찬]: 한국레노버 [후 원]: 한국PR협회(KPRA), 한국PR기업협회(KPRCA) [참여기업]: 한국레노버, 빛의 시어터, 생명보험사회공헌재단, 신용카드사회공헌재​단, 하나카드, 돌비, 어플라이드 머티어리얼즈, 한국제지연합회, 한국PR 협회, 리버마켓, 위니디, 아쿠라플라넷 여수 [공모 주제] - PR 기획 부문: 기업PR, 디지털PR, 마케팅PR, 브랜드PR, 공공PR, CSR(사회공헌활동), IMC 등을 주제로 한 PR 기획서 - 영상콘텐츠 제작부문: 기업PR영상, 광고PR영상, 바이럴 영상, SNS콘텐츠(숏폼 등) [공모 분량] - PR 기획 부문: PR기획서(국문 또는 영문) 50장 내외 (PPT 200MB 이내) - 영상콘텐츠 제작부문: 기획의도 및 컨셉(크리에이티브 기획안(1~2장 이내) + 제작물 500 MB 이내 (해상도1920*1080 / 유튜브 업로드 후 해당 URL 입력) [참가 자격]: 대학(전문대 포함) 및 대학원(석,박사 과정) 재학생 및 휴학생 (공고일 현재 기준) (팀 당 참가인원은 최대 4명까지로 제한) [참가 방법]: 응모신청 및 PR기획서, 영상(링크) 접수는 홈페이지 통해 온라인 접수 [공모 일정] - 응모신청 및 응모작품 접수: 2023년 11월 20일(월) ~ 2024년 1월 15일(월) (홈페이지접수) - 공모 심사: 2024년 1월 15일(월) ~ 2024년 2월 15일(목) - 1차심사: 서류심사 - 2차심사: 1차 프리젠테이션 심사 (대면 심사 예정) - 3차심사: 최종 프리젠테이션 심사 (대면 심사 예정) - 시상식: 2024년 2월 27일(수) (예정) [심사 기준] - PR부문: 상황(시장)분석, 논리적 구성, 제안 아이디어의 현실성 및 효율성, 비주얼 제안서 구성, 커뮤니케이션능력 등 - 영상부문: 주제 부합성(주제적합도/이해도), 표현력(연출방향/차별성/독창성), 대중성, 활용성(홍보활용성) [심사위원]: 학계, 고객사 및 주관사 등의 해당 분야 전문가 [심사절차]: 전체 응모작품에 대한 1차 서류심사를 진행하고, 1차 서류심사를 통과한 작품을 대상으로 2,3차 심사(프리젠테이션- 대면심사 예정)를 진행 [시상 내용] - 대 상(1) : 상장/상패 & 상금 500만원 - 최우수상(2) : 상장/상패 & 상금 200만원 (부문별 시상) - 우수상(2) : 상장/상패 & 상금 100만원 (부문별 시상) - 장려상(6) : 상장/상패 & 상금 50만원 (부문별 시상) - 특별상(1) : 미정 - 입 선(미정) : 상장 & 소정의 기념품 - 특전 : 대상 수상팀 팀원 중 1명에게 6개월간 KPR 인턴 자격 부여 [유의사항] - 응모작품은 반환하지 않습니다. - 다른 공모전에 기 제출 또는 수상한 적이 있는 작품이거나, 순수창작물이 아닌 것으로 판명될 시에는 수상 후에도 입상이 취소될 수 있습니다. [문의 및 제출처] - 제출방법: 홈페이지를 통해 온라인 접수 - 주 소: 서울특별시 중구 퇴계로 173 (충무로 3가) 남산스퀘어 14층 KPR 대학생 PR 아이디어 공모전 담당자 (우편번호: 04554) - 문 의: 전화 (02) 3406-2158 이메일: praward@kpr.co.kr  대학생 대외활동 공모전 채용 사이트 링커리어 https://linkareer.com/"
        $0.font = .body3
        $0.textColor = .puzzleGray800
        $0.numberOfLines = 0
    }

    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .puzzleGray100
        
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        addSubviews(competitionTitleLabel,
                    competitionHostLabel,
                    teamImage,
                    teamLabel,
                    checkImage,
                    checkLabel,
                    heartImage,
                    heartLabel,
        
                    fieldLabel,
                    prizeLabel,
                    hostLabel,
                    periodLabel,
                    descriptionLabel,
                    
                    fieldInfoLabel,
                    prizeInfoLabel,
                    hostInfoLabel,
                    periodInfoLabel,
                    descriptionInfoLabel)
    }
    
    private func setLayout() {
        
        //TODO: - 정보 부분 글자 수 최대에 대한 leading, trailing 제약 설정
        
        // 정보
        competitionTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }
        competitionHostLabel.snp.makeConstraints {
            $0.top.equalTo(competitionTitleLabel.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
        }
        
        // 아이콘
        teamImage.snp.makeConstraints {
            $0.top.equalTo(competitionHostLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(18)
        }
        teamLabel.snp.makeConstraints {
            $0.top.equalTo(teamImage.snp.bottom).offset(4)
            $0.centerX.equalTo(teamImage.snp.centerX)
        }
        
        checkImage.snp.makeConstraints {
            $0.trailing.equalTo(teamImage.snp.leading).offset(-65)
            $0.top.equalTo(teamImage.snp.top)
            $0.size.equalTo(18)
        }
        checkLabel.snp.makeConstraints {
            $0.top.equalTo(checkImage.snp.bottom).offset(4)
            $0.centerX.equalTo(checkImage.snp.centerX)
        }
        
        heartImage.snp.makeConstraints {
            $0.leading.equalTo(teamImage.snp.trailing).offset(65)
            $0.top.equalTo(teamImage.snp.top)
            $0.size.equalTo(18)
        }
        heartLabel.snp.makeConstraints {
            $0.top.equalTo(heartImage.snp.bottom).offset(4)
            $0.centerX.equalTo(heartImage.snp.centerX)
        }
        
        // 상세 정보
        fieldLabel.snp.makeConstraints {
            $0.top.equalTo(teamLabel.snp.bottom).offset(42)
            $0.leading.equalToSuperview().inset(40)
        }
        prizeLabel.snp.makeConstraints {
            $0.top.equalTo(fieldInfoLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(40)
        }
        hostLabel.snp.makeConstraints {
            $0.top.equalTo(prizeInfoLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(40)
        }
        periodLabel.snp.makeConstraints {
            $0.top.equalTo(hostInfoLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(40)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(periodInfoLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(40)
        }
        
        fieldInfoLabel.snp.makeConstraints {
            $0.top.equalTo(fieldLabel.snp.top)
            $0.leading.equalTo(fieldLabel.snp.trailing).offset(49)
            $0.trailing.lessThanOrEqualToSuperview().inset(40).priority(.high)
        }
        prizeInfoLabel.snp.makeConstraints {
            $0.top.equalTo(prizeLabel.snp.top)
            $0.leading.equalTo(fieldInfoLabel.snp.leading)
            $0.trailing.lessThanOrEqualToSuperview().inset(40).priority(.high)
        }
        hostInfoLabel.snp.makeConstraints {
            $0.top.equalTo(hostLabel.snp.top)
            $0.leading.equalTo(prizeInfoLabel.snp.leading)
            $0.trailing.lessThanOrEqualToSuperview().inset(40).priority(.high)
        }
        periodInfoLabel.snp.makeConstraints {
            $0.top.equalTo(periodLabel.snp.top)
            $0.leading.equalTo(prizeInfoLabel.snp.leading)
            $0.trailing.lessThanOrEqualToSuperview().inset(40).priority(.high)
        }
        descriptionInfoLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(descriptionLabel.snp.leading)
            $0.trailing.lessThanOrEqualToSuperview().inset(40).priority(.high)
        }
    }
}
