//
//  CharProfileView.swift
//  RandMorty
//
//  Created by Максим Сулим on 19.08.2023.
//

import UIKit


class CharProfileView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    func configure() {
        tableView.backgroundColor = Resources.Color.blackBackGround
        self.backgroundColor = Resources.Color.blackBackGround
    }
}
