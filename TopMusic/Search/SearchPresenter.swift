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
  
  }
  
}
