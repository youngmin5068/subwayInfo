//
//  StationResponseModel.swift
//  subwayInfo
//
//  Created by 김영민 on 2021/12/23.
//

import Foundation


struct StationResponseModel : Decodable {
    
    var stations: [Station] {searchInfo.row}
    
    private let searchInfo: SearchInfoBySubwayNameServiceModel
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
    
    struct SearchInfoBySubwayNameServiceModel: Decodable {
        var row : [Station] = []
    }
}

struct Station : Decodable {
    let stationName: String
    let lineNumber: String
    
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
    }
}
