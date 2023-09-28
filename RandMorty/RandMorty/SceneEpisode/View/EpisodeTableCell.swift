//
//  EpisodeTableCellTableViewCell.swift
//  RandMorty
//
//  Created by Максим Сулим on 27.09.2023.
//

import UIKit

class EpisodeTableCell: UITableViewCell {

    
    @IBOutlet weak var backImageEpisode: UIImageView!
    @IBOutlet weak var nameEpisodeLable: UILabel!
    @IBOutlet weak var numberEpisodeLable: UILabel!
    @IBOutlet weak var dateEpisodeLable: UILabel!
    
    struct ModelEpisode {
        var name: String = ""
        var number: String = ""
        var date: String = ""
    }
    
    var model = ModelEpisode()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureDef()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func configureDef() {
        self.contentView.layer.backgroundColor = Resources.Color.blackBackGround.cgColor
        backImageEpisode.layer.backgroundColor = Resources.Color.blackGrayBackGround.cgColor
        backImageEpisode.layer.cornerRadius = 20
        nameEpisodeLable.textColor = Resources.Color.infoWhite
        numberEpisodeLable.textColor = Resources.Color.poisonousGreen
        dateEpisodeLable.textColor = Resources.Color.infoLightGray
    }
    
    func configureEpisodeCell(model: ModelEpisode) {
         nameEpisodeLable.text = model.name
         numberEpisodeLable.text = model.number
         dateEpisodeLable.text = model.date
    }

}
