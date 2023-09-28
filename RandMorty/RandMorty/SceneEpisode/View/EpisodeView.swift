//
//  EpisodeView.swift
//  RandMorty
//
//  Created by Максим Сулим on 27.09.2023.
//

import UIKit

class EpisodeView: UIView {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    func configure() {
        self.tableView.backgroundColor = Resources.Color.blackBackGround
        self.backgroundColor = Resources.Color.blackBackGround
    }

}
