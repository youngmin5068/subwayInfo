//
//  DetailStationCell.swift
//  subwayInfo
//
//  Created by 김영민 on 2021/12/22.
//

import SnapKit
import UIKit

class DetailStationCell : UICollectionViewCell {
    
    
    private lazy var lineLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        
        return label
    }()
    
    private lazy var remainTimeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        
        return label
    }()
    
    func setupLayout(with realTimeArrival: StationArrivalDataResponseModel.realtimeArrivalList) {
        
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 12.0
        
        backgroundColor = .systemBackground
        
        [lineLabel,remainTimeLabel].forEach{ addSubview($0) }
        
        lineLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
        }
        
        remainTimeLabel.snp.makeConstraints{
            $0.leading.equalTo(lineLabel.snp.leading)
            $0.top.equalTo(lineLabel.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview().inset(16.0)
        }
        
        lineLabel.text = realTimeArrival.line
        remainTimeLabel.text = realTimeArrival.remainTime
        
    }
}
