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
    
    // property CharProfile
    var episodeUrl: [String]?
    var char: CharacterModel?
    var charProfile: ResultChar?
    
    var charsFromApi = [ResultChar]()
    var nextUrlChars: String = "" {
        didSet {
            self.isLoadedChars = false
        }
    }
    var chars = [CharacterModel]()
    //id char and image
    var charsImage = [Int:Data]()
    // load characters
    var isLoadedChars = false
    
    private var characterView: CharacterView? {
        
        guard isViewLoaded else {
            return nil
        }
        return (view as! CharacterView)
    }
    
    private func configureNavigation() {
        self.navigationItem.title = "Character"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func configure() {
        characterView?.collectionView.delegate = self
        characterView?.collectionView.dataSource = self
        characterView?.collectionView.collectionViewLayout = configureCollectionLayout()
        configureNavigation()
        characterView?.configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
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
                self.charsFromApi += resultData.results
                self.nextUrlChars = resultData.info.next
                                
            } else {
                print(error!.localizedDescription)
                
            }
        }
    }
    
   private func appCharsFromApi(resultsChar: [ResultChar]) {
        
       var charsFromApi = [CharacterModel]()
       
       for i in 0..<resultsChar.count {
           
           let title = resultsChar[i].name
           let id = resultsChar[i].id
           let urlImage = resultsChar[i].image
           
           charsFromApi.append(CharacterModel(title: title, imageUrl: urlImage, id: id))
        }
        
       self.chars += charsFromApi
       loadImageChar(chars: self.chars)
       self.characterView?.collectionView.reloadData()
    }
    
    private func loadImageChar(chars: [CharacterModel]) {
        
        for i in 0..<chars.count {
            
            let urlString = chars[i].imageUrl
            
            let id = chars[i].id
            
            NetworkRequest.shared.request(stringUrl: urlString) { result in
                
                switch result {
                    
                case .success(let data):
                    
                    do {
                        
                        self.charsImage[id] = data
                        self.characterView?.collectionView.reloadData()
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
        
        let imageData = charsImage[chars[indexPath.row].id]
        cell.configure(title: chars[indexPath.row].title, imageData: imageData)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageData = charsImage[chars[indexPath.row].id]
        charProfile = charsFromApi[indexPath.row]
        char = chars[indexPath.row]
        char?.image = imageData
        episodeUrl = charsFromApi[indexPath.row].episode
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == chars.count - 2 && isLoadedChars == false {
            loadCharacters(urlCharacters: self.nextUrlChars)
            self.characterView!.collectionView.reloadData()
            isLoadedChars = true
        }
    }
    
    private func configureCollectionLayout() -> UICollectionViewCompositionalLayout {
        
        
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(156), heightDimension: .absolute(202))
        
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        
        let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(202))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitems: [item])
        group.interItemSpacing = .fixed(25)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 16, leading: 20, bottom: 16, trailing: 20)
        
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}

