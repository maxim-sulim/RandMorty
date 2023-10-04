//
//  CharFromEpizodeCell.swift
//  RandMorty
//
//  Created by Максим Сулим on 04.10.2023.
//

import UIKit

class CharFromEpizodeCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.backgroundColor = .darkGray
        
    }
}
