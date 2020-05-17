//
//  TrackCell.swift
//  TopMusic
//
//  Created by Кирилл Медведев on 14.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

protocol TrackCellViewModel {
    var iconUrlStirng: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
}

class TrackCell: UITableViewCell {
    
    static let reuseId = String(describing: TrackCell.self)
    var cell: SearchViewModel.Cell?
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var addTrackLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    @IBAction func addTrack(_ sender: Any) {
        let defalts = UserDefaults.standard
        guard let cell = cell else { return }
        addTrackLabel.isHidden = true
        var lisfOfTracks = defalts.savedTracks()
        
        lisfOfTracks.append(cell)
        
        if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: lisfOfTracks, requiringSecureCoding: false) {
            defalts.set(saveData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
    func set(viewModel: SearchViewModel.Cell) {
        
        self.cell = viewModel
        
        let savedTracks = UserDefaults.standard.savedTracks()
        let hasFavorites = savedTracks.firstIndex(where: {$0.trackName == self.cell?.trackName && $0.artistName == cell?.artistName}) != nil
        if hasFavorites {
            addTrackLabel.isHidden = true
        } else {
            addTrackLabel.isHidden = false
        }
        
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlStirng ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
}
