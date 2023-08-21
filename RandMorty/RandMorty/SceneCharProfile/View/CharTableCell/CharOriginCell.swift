//
//  CharOriginCell.swift
//  RandMorty
//
//  Created by Максим Сулим on 17.08.2023.
//

import UIKit

class CharOriginCell: UITableViewCell {

    
    struct OriginViewModel {
        var imagePlanet: Data?
        var namePlanet: String = ""
    }
    
    private var originModel = OriginViewModel()
    
    @IBOutlet weak var backOriginView: UIImageView!
    @IBOutlet weak var imagePlanet: UIImageView!
    @IBOutlet weak var labelPlanet: UILabel!
    @IBOutlet weak var namePlanet: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureDef()
    }


    private func configureDef() {
        self.contentView.backgroundColor = Resources.Color.blackBackGround
        backOriginView.backgroundColor = Resources.Color.blackGrayBackGround
        backOriginView.layer.cornerRadius = 16
        imagePlanet.layer.cornerRadius = 10
        imagePlanet.backgroundColor = Resources.Color.backOriginGround
        labelPlanet.text = "Planet"
        labelPlanet.textColor = Resources.Color.infoTexlChar
        namePlanet.textColor = Resources.Color.poisonousGreen
        imagePlanet.image = UIImage(named: "Planet")
        imagePlanet.contentMode = .center
    }
    
    func configure(with originModel: OriginViewModel) {
        
        self.originModel = originModel
        
        namePlanet.text = originModel.namePlanet
    }
    
}
