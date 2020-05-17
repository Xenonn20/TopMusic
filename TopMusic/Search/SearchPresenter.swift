//
//  SearchPresenter.swift
//  TopMusic
//
//  Created by Кирилл Медведев on 13.05.2020.
//  Copyright (c) 2020 Kirill Medvedev. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    func presentData(response: Search.Model.Response.ResponseType) {
        
        switch response {
        case .presentTracks(let searchResults):
            let cells = searchResults?.results.map({ (track)  in
                cellViewModel(from: track)
            }) ?? []
            
            let searchViewModel = SearchViewModel(cells: cells)
            viewController?.displayData(viewModel: .displayTracks(searchViewModel: searchViewModel))
        case .presentFooterView:
            viewController?.displayData(viewModel: .displayFooterView)
        }
        
    }
    
    private func cellViewModel(from track: Track) -> SearchViewModel.Cell {
        
        
        return SearchViewModel.Cell.init(iconUrlStirng: track.artworkUrl100,
                                         trackName: track.trackName,
                                         collectionName: track.collectionName ?? "",
                                         artistName: track.artistName,
                                         previewUrl: track.previewUrl ?? "")
    }
}
