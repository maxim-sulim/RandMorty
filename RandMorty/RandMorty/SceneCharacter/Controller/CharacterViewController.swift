//
//  ViewController.swift
//  RandMorty
//
//  Created by Максим Сулим on 17.08.2023.
//

import UIKit

protocol CharProtocol: AnyObject {
    var char: CharacterModel? { get set }
    var charProfile: ResultChar? { get set }
    var episodeUrl: [String]? { get set }
}

class CharacterViewController: UIViewController, CharProtocol {
    
    override func loadView() {
        super.loadView()
        startRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    var episodeUrl: [String]?
    var char: CharacterModel?
    var charProfile: ResultChar?
    var charsApi = [ResultChar]()
    var chars = [CharacterModel]()
    var charsImage: [Data]?
    
    private var characterView: CharacterView? {
        
        guard isViewLoaded else {
            return nil
        }
        return (view as! CharacterView)
    }
    
    private func configureNavigation() {
        self.navigationItem.title = "Character"
        
    }
    
    private func configure() {
        characterView?.collectionView.delegate = self
        characterView?.collectionView.dataSource = self
        configureNavigation()
        characterView?.configure()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCharProfile" {
            
            guard let vc = segue.destination as? CharProfileController else {
                return
            }
            vc.delegate = self
            
        }
    }
        
}

//MARK: - Work request

extension CharacterViewController {
    
    private func startRequest() {
        
        let urlString = StartApi.startApi.rawValue
        
        NetworkData.shared.workDataStartRequest(urlString: urlString) { result, error in
            
            if error == nil {
               
                guard let resultData = result else {
                    return
                }
        
                self.loadCharacters(urlCharacters: resultData.characters)
                
            } else {
                print(error!.localizedDescription)
                
            }
        }
    }
    
    private func loadCharacters(urlCharacters: String) {
        
        let urlString = urlCharacters
        
        NetworkData.shared.workDataCharacters(urlString: urlString) { result, error in
            
            if error == nil {
               
                guard let resultData = result else {
                    return
                }
                
                self.appCharsFromApi(resultsChar: resultData.results)
                self.charsApi = resultData.results
                                
            } else {
                print(error!.localizedDescription)
                
            }
        }
    }
    
   private func appCharsFromApi(resultsChar: [ResultChar]) {
        
       var charsFromApi = [CharacterModel]()
       loadImageChar(results: resultsChar)
       
       for i in 0..<resultsChar.count {
           
           let title = resultsChar[i].name
           let id = resultsChar[i].id
           charsFromApi.append(CharacterModel(title: title, id: id))
        }
        
       self.chars = charsFromApi
       self.characterView?.collectionView.reloadData()
    }
    
    private func loadImageChar(results: [ResultChar]) {
        
        var imageArrChars = [Data]()
        
        for i in 0..<results.count {
            
            let urlString = results[i].image
            
            NetworkRequest.shared.request(stringUrl: urlString) { result in
                
                switch result {
                    
                case .success(let data):
                    
                    do {
                        imageArrChars.append(data)
                        
                        if i == results.count - 1 {
                            self.charsImage = imageArrChars
                            self.characterView?.collectionView.reloadData()
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                    
                }
            }
        }
    }
    
}


//MARK: - Work collection delegate

extension CharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        chars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharCollectionCell", for: indexPath) as!
                CharCollectionCell
        
        cell.configure(title: chars[indexPath.row].title,
                       imageData: charsImage?.saveObject(at: indexPath.row))
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        charProfile = charsApi[indexPath.row]
        char = chars[indexPath.row]
        char?.image = charsImage![indexPath.row]
        episodeUrl = charsApi[indexPath.row].episode
    }
    
    
}

