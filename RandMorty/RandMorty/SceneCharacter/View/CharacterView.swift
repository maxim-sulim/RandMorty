//
//  CharacterView.swift
//  RandMorty
//
//  Created by Максим Сулим on 17.08.2023.
//

import UIKit

class CharacterView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func configure() {
        collectionView.backgroundColor = Resources.Color.blackBackGround
        self.backgroundColor = Resources.Color.blackBackGround
    }
}
