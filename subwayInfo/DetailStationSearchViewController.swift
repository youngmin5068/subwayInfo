//
//  DetailStationSearchViewController.swift
//  subwayInfo
//
//  Created by 김영민 on 2021/12/22.
//

import UIKit
import SnapKit
import Alamofire

class DetailStationSearchViewController : UIViewController {
    private let station : Station
    private var realtimeArrivalList: [StationArrivalDataResponseModel.realtimeArrivalList] = []
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
       
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        return refreshControl
    }()
    
    @objc func fetchData() {
        let stationName = station.stationName
        
        let urlString = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(stationName)"
        
        AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationArrivalDataResponseModel.self) {[weak self] response in
                
                self?.refreshControl.endRefreshing()
                
                
                guard case .success(let data) = response.result else {return}
                
                self?.realtimeArrivalList = data.realtimeArrivalList
                self?.collectionView.reloadData()
       
            }.resume()
    }
    
    private lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.width - 32.0, height: 100.0)
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        
        collectionView.backgroundColor = .systemBackground
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DetailStationCell.self,forCellWithReuseIdentifier: "DetailStationCell")
        
        collectionView.refreshControl = refreshControl
        
        return collectionView
    }()
    
    init(station: Station)
    {
        self.station = station
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "\(station.stationName)"
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        fetchData()
    }
}


extension DetailStationSearchViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realtimeArrivalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailStationCell", for: indexPath) as? DetailStationCell
        
        
        
        let realTimeArrival = realtimeArrivalList[indexPath.row]

        cell?.setupLayout(with: realTimeArrival)
        
        return cell ?? UICollectionViewCell()

    }
    
    
}
extension DetailStationSearchViewController : UICollectionViewDelegateFlowLayout {
    
}
