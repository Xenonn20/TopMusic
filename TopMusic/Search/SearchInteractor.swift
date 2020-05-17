//
//  SearchInteractor.swift
//  TopMusic
//
//  Created by Кирилл Медведев on 13.05.2020.
//  Copyright (c) 2020 Kirill Medvedev. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {
    
    let networkService = NetworkService.shared
    
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        switch request {
        case .getTracks(let searchTerm):
            presenter?.presentData(response: .presentFooterView)
            networkService.fetchTracks(searchText: searchTerm) { [weak self](searchResponse) in
                self?.presenter?.presentData(response: .presentTracks(searchResponse: searchResponse))
            }
        }
    }
    
    
}
