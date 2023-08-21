//
//  CharacterModel.swift
//  RandMorty
//
//  Created by Максим Сулим on 17.08.2023.
//

import Foundation

protocol CharacterModelProtocol {
    var title: String { get set }
    var image: Data? { get set }
    var id: Int { get set }
}

struct CharacterModel {
     var title: String
     var image: Data?
     var id: Int
}

extension CharacterModel {
    
   public static func charOpen() -> CharacterModel {
        
       return CharacterModel(title: "1", id: 0)
    }
}
