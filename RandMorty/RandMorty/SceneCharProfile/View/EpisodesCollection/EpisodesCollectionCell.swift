//
//  EpisodesCollectionCell.swift
//  RandMorty
//
//  Created by Максим Сулим on 17.08.2023.
//

import UIKit

class EpisodesCollectionCell: UICollectionViewCell {
    
    struct EpisodeViewModel {
        var name: String
        var number: String
        var date: String
    }
    
    @IBOutlet weak var backgroundEpisodesView: UIImageView!
    @IBOutlet weak var nameEpisodes: UILabel!
    @IBOutlet weak var numberEpisodes: UILabel!
    @IBOutlet weak var dateEpisodes: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureDef()
    }    
    
    private func configureDef() {
        self.contentView.backgroundColor = Resources.Color.blackBackGround
        backgroundEpisodesView.backgroundColor = Resources.Color.blackGrayBackGround
        backgroundEpisodesView.layer.cornerRadius = 16
        nameEpisodes.textColor = Resources.Color.infoTexlChar
        numberEpisodes.textColor = Resources.Color.poisonousGreen
        dateEpisodes.textColor = Resources.Color.infoTextLabel
    }
    
    func configure(with episodeModel: EpisodeViewModel) {
        nameEpisodes.text = episodeModel.name
        numberEpisodes.text = episodeModel.number
        dateEpisodes.text = episodeModel.date
    }
}
