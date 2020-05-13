//
//  SearchMusicViewController.swift
//  TopMusic
//
//  Created by Кирилл Медведев on 13.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import Foundation
import UIKit


class SearchMusicViewController: UITableViewController {
    
    let networkService = NetworkService.shared
    var timer: Timer?
    
    var tracks = [Track]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSearchBar()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        let track = tracks[indexPath.row]
        cell.textLabel?.text = track.artistName
        cell.textLabel?.numberOfLines = 2
        return cell
    }
}

extension SearchMusicViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkService.fetchTracks(searchText: searchText) { [weak self] (searchResponse) in
                self?.tracks = searchResponse?.results ?? []
                self?.tableView.reloadData()
            }
        })
    }
    
}
