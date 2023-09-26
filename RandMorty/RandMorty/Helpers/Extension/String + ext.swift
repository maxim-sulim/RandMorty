//
//  String + ext.swift
//  RandMorty
//
//  Created by Максим Сулим on 26.09.2023.
//

import Foundation

extension String {
    
    func localized() -> String {
        NSLocalizedString(self,
                          tableName: "Localizable",
                          bundle: .main,
                          value: self,
                          comment: "")
    }
    
}
