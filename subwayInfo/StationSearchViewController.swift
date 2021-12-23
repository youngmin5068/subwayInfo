//
//  ViewController.swift
//  subwayInfo
//
//  Created by 김영민 on 2021/12/22.
//

import UIKit
import SnapKit
import Alamofire

class StationSearchViewController: UIViewController {
    
    private var numberofcells = 0
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        setNavigationItems()
        setTableViewLayout()
        
        requestStationName()
    }
    
    
    private func setTableViewLayout() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
    }
    
    private func setNavigationItems() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철 역을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false //TODO
        searchController.searchBar.delegate = self
        
        
        navigationItem.searchController = searchController
    }
    
    private func requestStationName() {
        let urlString = "http://openapi.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/종로3가/"
       
        AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationResponseModel.self) { response in
                guard case .success(let data) = response.result else {return}
                
                print(data.stations)
            }
            .resume()
    }


}

extension StationSearchViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        numberofcells = 10
        tableView.isHidden = false
        tableView.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        numberofcells = 0
        tableView.isHidden = true
    }
    
}

extension StationSearchViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numberofcells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "\(indexPath.item)"
        cell.textLabel?.textColor = .blue
        
        return cell
    }

}

extension StationSearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC =  DetailStationSearchViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
}
