//
//  NetworkService.swift
//  TopMusic
//
//  Created by Кирилл Медведев on 13.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import Alamofire
import UIKit

class NetworkService {
    
    static let shared = NetworkService()
    let url = "https://itunes.apple.com/search"
    
    func fetchTracks(searchText: String, completion: @escaping (SearchResponse?) -> Void) {
        let parametrs = [
            "term": "\(searchText)",
            "limit": "10",
            "media": "music"
        ]
        AF.request(url, method: .get, parameters: parametrs, encoder: URLEncodedFormParameterEncoder.default).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            let decoder = JSONDecoder()

            do {
                let object = try decoder.decode(SearchResponse.self, from: data)
                completion(object)
            } catch let jsonError {
                print(jsonError)
                completion(nil)
            }
        }
    }
}

