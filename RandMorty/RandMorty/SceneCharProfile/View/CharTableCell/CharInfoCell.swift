//
//  CharInfoCell.swift
//  RandMorty
//
//  Created by Максим Сулим on 17.08.2023.
//

import UIKit

class CharInfoCell: UITableViewCell {

    private enum TitleLable: String {
        case speciesLable = "Species"
        case typeLable = "Type"
        case genderLabel = "Gender"
    }
    
    struct InfoModelView {
        var species: String = ""
        var type: String = ""
        var gender: String = ""
    }
    
    @IBOutlet weak var lableSpecies: UILabel!
    @IBOutlet weak var lableType: UILabel!
    @IBOutlet weak var lableGender: UILabel!
    
    
    @IBOutlet weak var backInfoView: UIImageView!
    @IBOutlet weak var speciesChar: UILabel!
    @IBOutlet weak var typeChar: UILabel!
    @IBOutlet weak var genderChar: UILabel!
    
    
    private var infoModel = InfoModelView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureDef()
    }
    
    func configure(with infoModel: InfoModelView) {
        
        self.infoModel = infoModel
        
        if infoModel.type == "" {
            typeChar.text = "Base"
        } else {
            typeChar.text = infoModel.type
        }
        
        speciesChar.text = infoModel.species
        genderChar.text = infoModel.gender
        
    }
    
    private func configureDef() {
        
        self.contentView.backgroundColor = Resources.Color.blackBackGround
        backInfoView?.layer.cornerRadius = 16
        backInfoView?.backgroundColor = Resources.Color.blackGrayBackGround
        lableSpecies.textColor = Resources.Color.infoLightGray
        lableSpecies.text = TitleLable.speciesLable.rawValue.localized()
        lableType.textColor = Resources.Color.infoLightGray
        lableType.text = TitleLable.typeLable.rawValue.localized()
        lableGender.textColor = Resources.Color.infoLightGray
        lableGender.text = TitleLable.genderLabel.rawValue.localized()
        speciesChar.textColor = Resources.Color.infoWhite
        typeChar.textColor = Resources.Color.infoWhite
        genderChar.textColor = Resources.Color.infoWhite
    }
    

}
