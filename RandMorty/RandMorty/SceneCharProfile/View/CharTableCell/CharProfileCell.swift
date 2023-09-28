//
//  CharProfileCell.swift
//  RandMorty
//
//  Created by Максим Сулим on 17.08.2023.
//

import UIKit

class CharProfileCell: UITableViewCell {

    
    struct ProfileViewModel{
        var imageChar: Data?
        var nameChar: String = ""
        var lifeStatusChar: String = ""
    }
    
    private var profileModel = ProfileViewModel()
    
    @IBOutlet weak var imageCharProfile: UIImageView!
    @IBOutlet weak var nameCharProfile: UILabel!
    @IBOutlet weak var lifeStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureDef()
    }
    
    private func configureDef() {
        self.contentView.backgroundColor = Resources.Color.blackBackGround
        imageCharProfile.layer.cornerRadius = 16
        lifeStatus.textColor = Resources.Color.poisonousGreen
        nameCharProfile.textColor = Resources.Color.infoWhite
        nameCharProfile.text = "Rick sunzhes"
    }
    
    func configure(with profileModel: ProfileViewModel) {
        
        self.profileModel = profileModel
        
        if profileModel.imageChar != nil {
            let image = UIImage(data: profileModel.imageChar!)
            imageCharProfile.image = image
        }
        
        nameCharProfile.text = profileModel.nameChar
        lifeStatus.text = profileModel.lifeStatusChar
    }

}
