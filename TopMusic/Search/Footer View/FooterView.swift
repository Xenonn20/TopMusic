//
//  FooterView.swift
//  TopMusic
//
//  Created by Кирилл Медведев on 14.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import Foundation
import UIKit

class FooterView: UIView {
    
    private let waitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.631372549, green: 0.6470588235, blue: 0.662745098, alpha: 1)
        
        return label
    }()
    
    private let loaderView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        
        return loader
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(waitLabel)
        addSubview(loaderView)
        
        addConstraints([
            loaderView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            loaderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            loaderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            waitLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            waitLabel.topAnchor.constraint(equalTo: loaderView.bottomAnchor, constant: 8)
        ])
    }
    
    func showLoader(isActive: Bool) {
        if isActive{
            loaderView.startAnimating()
            waitLabel.text = "Loading"
        } else {
            loaderView.stopAnimating()
            waitLabel.text = ""
        }
    }
}
