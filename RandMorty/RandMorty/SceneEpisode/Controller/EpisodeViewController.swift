//
//  EpisodeViewController.swift
//  RandMorty
//
//  Created by Максим Сулим on 27.09.2023.
//

import UIKit

class EpisodeViewController: UIViewController {

    enum SectionEpisodeTable: Int {
        case episodeSection = 0
        case charsSection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeView?.configure()
        configureDef()
    }
    
    private var episodeView: EpisodeView? {
        
        guard isViewLoaded else {
            return nil
        }
        return (view as! EpisodeView)
    }
    
    weak var delegateEpisode: EpisodeProtocol?
    
    private func configureDef() {
        episodeView?.tableView.delegate = self
        episodeView?.tableView.dataSource = self
    }

}


extension EpisodeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath.row {
            
        case SectionEpisodeTable.episodeSection.rawValue:
            
            let newCell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableCell") as! EpisodeTableCell
            
            let model = delegateEpisode?.episodeModel
            
            newCell.configureEpisodeCell(model: EpisodeTableCell.ModelEpisode(name: model!.name,
                                                                              number: model!.number,
                                                                              date: model!.date))
            cell = newCell
            
        default:
            return cell
        }
        return cell
    }
    
}
