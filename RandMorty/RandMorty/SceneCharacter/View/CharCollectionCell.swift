//
//  CharCollectionCell.swift
//  RandMorty
//
//  Created by Максим Сулим on 17.08.2023.
//

import UIKit

class CharCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleChar: UILabel!
    @IBOutlet weak var imageChar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageChar.layer.cornerRadius = 10
        imageChar.contentMode = .scaleToFill
        self.contentView.backgroundColor = Resources.Color.blackGrayBackGround
        self.contentView.layer.cornerRadius = 16
        
    }
    
    func configure(title: String, imageData: Data?) {
        titleChar.text = title
        titleChar.textColor = .white
        
        if let data = imageData {
            imageChar.image = UIImage(data: data)
        }
        
    }
}
