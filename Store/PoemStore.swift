//
//  File.swift
//  
//
//  Created by Yun Dongbeom on 2023/04/17.
//

import Foundation

class PoemStore: ObservableObject {
    private let poemA = PoemInfo(
        krInfo: (
        "깃발",
        """
        이것은 소리없는 아우성.
        
        저 푸른 해원(海原)을 향하여 흔드는
        영원한 노스탤지어의 손수건.
        
        순정은 물결같이 바람에 나부끼고
        오로지 맑고 곧은 이념의 푯대 끝에
        애수(哀愁)는 백로처럼 날개를 펴다
        
        아아 누구던가.
        
        이렇게 슬프고도 애달픈 마음을
        맨 처음 공중에 달 줄을 안 그는.
        """,
        "유치환"),
        enInfo: (
        "Flag",
        """
        This is a silent cry.
        
        An eternal handkerchief of nostalgia
        Waving toward that vast blue ocean.
        
        Pure love flutters in the wind like waves
        Hung on a post of only clear and straight ideology.
        Sorrow spreads its wings like a white heron.
        
        Ah! Who is the person,
        
        Who's got to know to hang the mind of heartrending
        sorrow In the air for the first time?
        """,
        "Yu Chi-hwan"
        ),
        firstPhrase: "이것은 소리없는 아우성",
        thumbChar: "가")
    private let poemB = PoemInfo(
        krInfo: (
        "내 마음은",
        """
        내 마음은 호수요,
        그대 노 저어 오오.
        
        나는 그대의 흰 그림자를 안고, 옥 같이
        그대의 뱃전에 부서지리라.
        
        내 마음은 촛불이요,
        그대 저 문을 닫아 주오.
        
        나는 그대의 비단 옷자락에 떨며, 고요히
        최후의 한 방울도 남김없이 타오리다.
        
        내 마음은 나그네요,
        그대 피리를 불어주오,
        
        나는 달 아래 귀를 기울이며, 호젓이
        나의 밤을 새이오리다.
        
        내 마음은 낙엽이요,
        잠깐 그대의 뜰에 머무르게 하오.
        
        이제 바람이 일면 나는 또 나그네같이, 외로이
        그대를 떠나오리다.
        """,
        "김동명"
        ),
        enInfo: (
        "My Heart",
        """
        My heart is lake.
        Row toward me, love.
        
        Your white shadow I’ll take in my arms,
        I’ll break like jade on your prow.
        
        My heart is a lamp.
        Close that door, love.
        
        I’ll burn in silence to the last drop
        Shimmering on your silken dress.
        
        My heart is a wayfarer.
        Play your pipe, love.
        
        I’ll bend my ear in the moonlight.
        And listen desolate through the night.
        
        My heart is a fallen leaf.
        Let me stay a moment in your garden, love.
        
        I’ll leave when the wind rises again
        And go my lonely wayfarer road.
        """,
        "Kim Dong-Myung"
        ),
        firstPhrase: "내 마음은 호수요 그대 노 저어 오오",
        thumbChar: "나")
    private let poemC = PoemInfo(
        krInfo: (
        "진달래꽃",
        """
        나 보기가 역겨워
        가실 때에는
        말없이 고이 보내 드리우리다
        
        영변에 약산
        진달래꽃
        아름 따다 가실 길에 뿌리우리다
        
        가시는 걸음걸음
        놓인 그 꽃을
        사뿐히 즈려밟고 가시옵소서
        
        나 보기가 역겨워
        가실 때에는
        죽어도 아니 눈물 흘리우리다
        """,
        "김소월"
        ),
        enInfo: (
        "Azaleas",
        """
        When you leave
        tired of me,
        without saying anything, I shall gently let you go
        
        From Yaksan in Nyongbyon,
        I shall pluck an armful of azaleas
        and scatter them on the path down which you go
        
        As you make your way, step by step,
        upon the scattered flowers lain before you,
        Please tread gently as you go
        
        When you leave
        tired of me,
        Even in death shall no tears flow,
        """,
        "Kim Sowol"
        ),
        firstPhrase: "나 보기가 역겨워 가실 때에는 말없이 고이 보내 드리우리다",
        thumbChar: "다")
    private let poemD = PoemInfo(
        krInfo: (
        "낙화",
        """
        가야할 때가 언제인가를
        분명히 알고 가는 이의
        뒷모습은 얼마나 아름다운가.
        
        봄 한철
        격정을 인내한
        나의 사랑은 지고 있다.
        
        분분한 낙화 . . .
        결별이 이룩하는 축복에 싸여
        지금은 가야할 때
        
        무성한 녹음과 그리고
        머지않아 열매 맺는
        가을을 향하여
        나의 청춘은 꽃답게 죽는다.
        
        헤어지자
        섬세한 손길을 흔들며
        하롱하롱 꽃잎이 지는 어느날
        
        나의 사랑, 나의 결별
        샘터에 물 고인 듯 성숙하는
        내 영혼의 슬픈 눈.
        """,
        "이형기"
        ),
        enInfo: (
        "Falling Leaves",
        """
        How beautiful it must be to see,
        He who knows his time to go will come someday,
        just turn his back and walk away
        
        In the Spring
        my love, having endured such passions,
        drifts away.
        
        Falling leaves lie scattered…
        wrapped in the blessing of a parting well done
        now the time to go has come
        
        Towards the lush greenness,
        And, before long,
        fruitfulness of Fall
        The springtime of my life is fading like a flower
        
        So let us part, some day
        Departing upon a delicate wave
        As the leaves around us cascade, carelessly
        
        My love, my parting,
        Maturing, mournful eyes of my soul,
        Brimming like water by a spring
        """,
        "Lee Hyeong-Gi"
        ),
        firstPhrase: "가야할 때가 언제인가를 분명히 알고 가는 이의 뒷모습은 얼마나 아름다운가",
        thumbChar: "라")
    
    init() {
        poems = [poemA, poemB, poemC, poemD]
    }
    
    @Published
    var poems: [PoemInfo] = []
    
    @Published
    var isPopupActive = false
    
}

