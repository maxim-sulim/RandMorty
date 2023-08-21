//
//  CharProfileController.swift
//  RandMorty
//
//  Created by Максим Сулим on 17.08.2023.
//

import UIKit

protocol EpisodeProtocol: AnyObject {
    var episodeModel: [EpisodeCharModel] { get set }
}

struct EpisodeCharModel {
    var name: String
    var number: String
    var date: String
}


enum TittleCharTable: Int {
    case profile = 0
    case info
    case origin
    case episodes
}

class CharProfileController: UIViewController, EpisodeProtocol {

    
    weak var delegate: CharProtocol?
    var imageDataOrigin: Data?
    var episodeModel = [EpisodeCharModel]()
    
    
    
    private var charProfileView: CharProfileView? {
        
        guard isViewLoaded else {
            return nil
        }
        return (view as! CharProfileView)
    }
    
    
    override func loadView() {
        super.loadView()
        loadEpisode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.charProfileView?.configure()
        configureNavigate()
        self.view.backgroundColor = Resources.Color.blackBackGround
        self.charProfileView?.tableView.delegate = self
        self.charProfileView?.tableView.dataSource = self
    }
    
    private func configureNavigate() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .white
        }
    }
    
    private func returnHeightRowEpisode() -> CGFloat {
        
        let countEpisode = episodeModel.count * 24
        
        if countEpisode == 0 {
            return CGFloat(150)
        }
        return CGFloat(countEpisode)
    }
    
    
    
}

//MARK: - TableDelegateWork

extension CharProfileController: UITableViewDelegate, UITableViewDataSource {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
            
        case TittleCharTable.profile.rawValue: return nil
        case TittleCharTable.info.rawValue: return "Info"
        case TittleCharTable.origin.rawValue: return "Origin"
        case TittleCharTable.episodes.rawValue: return "Episodes"
            
        default:
            return nil
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath.section {
            
        case TittleCharTable.profile.rawValue:
            
            let newCell = tableView.dequeueReusableCell(withIdentifier: "CharProfileCell", for: indexPath) as! CharProfileCell
            
            
            newCell.configure(with: CharProfileCell.ProfileViewModel(
                imageChar: delegate?.char?.image,
                nameChar: (delegate?.charProfile!.name)!,
                lifeStatusChar: (delegate?.charProfile!.status)!))
            
            cell = newCell
            
        case TittleCharTable.info.rawValue:
            
            let newCell = tableView.dequeueReusableCell(withIdentifier: "CharInfoCell", for: indexPath) as! CharInfoCell
            
            newCell.configure(with: CharInfoCell.InfoModelView(
                species: (delegate?.charProfile!.species)!,
                type: (delegate?.charProfile!.type)!,
                gender: (delegate?.charProfile!.gender)!))
            
            cell = newCell
            
        case TittleCharTable.origin.rawValue:
            
            let newCell = tableView.dequeueReusableCell(withIdentifier: "CharOriginCell", for: indexPath) as! CharOriginCell
            
            let nameOrigin = delegate?.charProfile?.origin.name
            newCell.configure(with: CharOriginCell.OriginViewModel(imagePlanet: imageDataOrigin, namePlanet: nameOrigin!))
            cell = newCell
            
        case TittleCharTable.episodes.rawValue:
            
            let newCell = tableView.dequeueReusableCell(withIdentifier: "EpisodesCell", for: indexPath) as! EpisodesCell
            newCell.delegate = self
            cell = newCell
            
        default:
            return cell
        }
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if TittleCharTable.profile.rawValue == indexPath.section {
            return 268
        } else if TittleCharTable.info.rawValue == indexPath.section {
            return 158
        } else if TittleCharTable.origin.rawValue == indexPath.section {
            return 95
        } else {
            return  returnHeightRowEpisode()
        }
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == TittleCharTable.profile.rawValue {
            return CGFloat(0)
        } else {
            return CGFloat(35)
        }
    }
    
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = Resources.Color.blackBackGround
            headerView.backgroundView?.backgroundColor = Resources.Color.blackBackGround
            headerView.textLabel?.textColor = Resources.Color.infoTexlChar
        }
        
    }
    
}

//MARK: - work network

extension CharProfileController {
    
    private func loadImageOrigin(results: ResultChar) {
        
        let urlString = results.origin.url
            
            NetworkRequest.shared.request(stringUrl: urlString) { result in
                
                switch result {
                    
                case .success(let data):
                    
                    do {
                        self.imageDataOrigin = data
                        self.charProfileView!.tableView.reloadSections(IndexSet(integer: 2), with: .none)
                    }
                    
                case .failure(let error):
                    print(error)
                    
                }
            }
    }
    
    private func loadEpisode() {
        
        var episode = [EpisodeCharModel]()
        let episodeUrl: [String] = delegate?.episodeUrl ?? []
        
        guard episodeUrl.count != 0 else {
            return
        }
        
        for i in 0..<episodeUrl.count {
            
            let url = episodeUrl[i]
            
            NetworkData.shared.workDataEpisodeChar(urlString: url) { result, error in
                
                if error == nil {
                    
                    guard let resultData = result else {
                        return
                    }
                    
                    episode.append(EpisodeCharModel(name: resultData.name,
                                                    number: resultData.episode,
                                                    date: resultData.airDate))
                    
                    if i == episodeUrl.count - 1 {
                        self.episodeModel = episode
                        self.charProfileView?.tableView.reloadSections(IndexSet(integer: 3), with: .automatic)
                    }
                    
                } else {
                    print(error!.localizedDescription)
                    
                }
            }
        }
    }
    
    
}
