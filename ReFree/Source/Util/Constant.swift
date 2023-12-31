//
//  Constant.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/11.
//

import UIKit

struct Constant {
    static let spacing6: Int = 6
    static let spacing8: Int = 8
    static let spacing10: Int = 10
    static let spacing12: Int = 12
    static let spacing24: Int = 24
    static let spacing30: Int = 30
    static let spacing50: Int = 50
    static let spacing60: Int = 60
    
    static var screenSize: CGRect = .zero
    
    static var reFreeLogo = UIImage(named: "ReFree_non")
    
    static var category: [String] = {
       let categoryString = "밀, 모차렐라, 부추, 꼬막, 탄산수, 김치, 카레, 등심, 타르타르 소스, 감, 젓, 만두, 겉절이, 현미유, 골뱅이, 바게트, 어묵, 대파, 오징어채, 고구마, 바질, 밤, 차, 설탕, 배, 간장, 동태, 피망, 메밀, 닭다리, 북어, 팽이버섯, 베이컨, 깍두기, 아스파라거스, 타피오카, 낙지, 블루베리, 쑥갓, 양고기, 인삼, 코코아 파우더, 떡볶이, 다슬기, 쑥, 깻잎, 유자, 실고추, 무말랭이, 도토리, 파인애플, 버거, 스리라차 소스, 채끝, 보쌈, 천일염, 동치미, 아보카도, 게, 부채살, 크림치즈, 다랑어, 브로콜리, 참기름, 크래커, 고추, 오징어, 도미, 순두부, 삼계탕, 홍합, 죽순, 고추기름, 겨, 코코넛 밀크, 청, 실파, 시럽, 초고추장, 마요네즈, 두유, 호박, 새우젓, 참나물, 돌나물, 바나나, 호박씨, 미나리, 잡채, 미역, 비트, 아귀, 옥수수, 수박, 파프리카, 소주, 상추, 계피, 식용 꽃, 가자미, 빵가루, 베이킹파우더, 우엉, 호두, 삼치, 검은깨, 얼음, 스팸, 아몬드, 요플레, 미역줄기, 율무, 쌀가루, 와인, 참깨, 고수, 민어, 소고기, 주스, 자몽, 비스킷, 된장국, 참치, 메추리, 버터, 미숫가루, 버섯, 메주, 기름, 포도씨유, 포도, 우렁이, 오미자, 고기, 대두, 치킨, 알, 돼지고기, 등갈비, 토마토, 참외, 콩고기, 게맛살, 고등어, 콩기름, 전복, 파마산 치즈, 문어, 사이다, 막걸리, 굴, 잡곡, 머스터드, 햄, 쌈장, 무화과, 멜론, 감자, 포도주, 매실, 즙, 캐러멜, 떡, 사골, 샐러드, 강낭콩, 날치, 고명, 케첩, 나물, 조개, 양송이, 꽃게, 게살, 코코넛, 병아리콩, 고사리, 느타리, 까나리, 견과, 잡곡밥, 마늘, 사과, 오이, 매생이, 피자, 곶감, 채소, 족발, 냉국, 식초, 녹차, 피스타치오, 연어, 쇠고기, 코코아, 녹두, 소금, 귤, 해장국, 송이, 라즈베리, 콩나물, 김밥, 청주, 토란, 목이, 찹쌀, 토마토 소스, 불고기, 오레가노, 바지락, 분유, 들깨, 연근, 과일, 숙주, 소시지, 술, 떡갈비, 조청, 치즈, 차돌박이, 민트, 맛살, 도라지, 주꾸미, 당근, 홍시, 달래, 청양고추, 삼겹살, 단감, 밀가루, 고춧가루, 김, 산딸기, 낫토, 닭고기, 양배추, 젓갈, 대하, 새송이, 은행, 청국장, 물엿, 양지, 메밀묵, 부챗살, 국수, 밀면, 깨, 우유, 셀러리, 건포도, 라면, 현미, 오트밀, 소면, 장국, 호떡, 면, 빵, 유부, 키조개, 대구, 마늘종, 대추, 도토리묵, 관자, 당면, 완두, 취나물, 더덕, 미더덕, 피클, 오렌지, 장아찌, 복숭아, 망고, 장어, 아이스크림, 안심, 소다, 생강, 커피, 가다랑어, 달걀, 식혜, 찹쌀가루, 조랭이, 고추냉이, 백김치, 땅콩, 돈가스, 광어, 자두, 배추김치, 칼국수, 명태, 다시마, 닭, 새우, 멸치, 스프, 과메기, 키위, 계란찜, 쌀, 스테이크, 표고버섯, 열무김치, 정종, 명란젓, 파, 볶음밥, 병어, 된장, 식빵, 유, 꽁치, 두릅, 팥, 오곡, 두부, 연유, 계란, 갈비, 보리, 우동, 무, 사과 소스, 물, 목살, 조미료, 갈치, 통깨, 우렁, 후추, 체리, 소라, 콩, 배추, 비빔밥, 드레싱, 바비큐, 청경채, 겨자, 양파, 들기름, 황태, 가래떡, 라임, 맥주, 오렌지 주스, 레몬, 오리고기, 콜라, 쌀국수, 파슬리, 식용유, 꿀, 가쓰오부시, 석류, 멍게, 고추장, 누룽지, 조기, 다시다, 비지, 딸기, 초콜릿, 올리브, 쪽파, 귀리, 생선, 요구르트"
        
        var category = categoryString.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }.sorted()
        category.append("기타")
        return category
    }()
}
