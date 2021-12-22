//
//  ViewController.swift
//  subwayInfo
//
//  Created by 김영민 on 2021/12/22.
//

import UIKit
import SnapKit

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
        let vc = DetailStationSearchViewController()
        
        navigationController?.pushViewController(DetailStationSearchViewController(), animated: true)

    }
}
