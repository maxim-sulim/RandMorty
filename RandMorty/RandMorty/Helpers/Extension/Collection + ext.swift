//
//  Collection + ext.swift
//  RandMorty
//
//  Created by Максим Сулим on 19.08.2023.
//

import Foundation

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return saveObject(at: index)
    }
    func saveObject(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
