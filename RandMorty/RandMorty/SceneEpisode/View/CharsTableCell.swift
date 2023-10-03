//
//  CharsTableCell.swift
//  RandMorty
//
//  Created by Максим Сулим on 01.10.2023.
//

import UIKit

class CharsTableCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.backgroundColor = Resources.Color.blackGrayBackGround.cgColor
        self.contentView.layer.cornerRadius = 20
    }

   

}
