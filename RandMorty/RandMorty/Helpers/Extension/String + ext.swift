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
    
    func transformNumberEpisode() -> String {
       
       let apiStr = self
       var episodeOrSeason = ""
       let arrStr = Array(apiStr)
       var numberSeason = ""
       var numberEpisodes = ""
       
       for i in 0..<arrStr.count {
           
           if arrStr[i] == "S" {
               episodeOrSeason = "S"
           }
           
           if episodeOrSeason == "S" && arrStr[i].isNumber {
               
               if numberSeason.count == 0 && arrStr[i] == "0" {
                   continue
               } else {
                   numberSeason += String(arrStr[i])
               }
           }
           
           if arrStr[i] == "E" {
               episodeOrSeason = "E"
           }
           
           if episodeOrSeason == "E" && arrStr[i].isNumber {
               
               if numberEpisodes.count == 0 && arrStr[i] == "0" {
                   continue
               } else {
                   numberEpisodes += String(arrStr[i])
               }
           }
           
       }
       
       return "Episode: \(numberEpisodes), Season \(numberSeason)"
   }
    
}
