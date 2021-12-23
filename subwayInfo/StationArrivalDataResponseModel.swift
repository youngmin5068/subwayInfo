//
//  StationArrivalDataResponseModel.swift
//  subwayInfo
//
//  Created by 김영민 on 2021/12/23.
//

import Foundation

struct StationArrivalDataResponseModel : Decodable {
    
    var realtimeArrivalList: [realtimeArrivalList] = []
    
    struct realtimeArrivalList: Decodable {
        let line: String //~행
        let remainTime: String // 도착까지 남은 시간 or 전역 출발
        let currentStation: String // 현재 위치
        
        enum CodingKeys : String,CodingKey {
            case line = "trainLineNm"
            case remainTime = "arvlMsg2"
            case currentStation = "arvlMsg3"
        }
    }
}
