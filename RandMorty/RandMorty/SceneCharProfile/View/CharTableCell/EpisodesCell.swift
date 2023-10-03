//
//  EpisodesCell.swift
//  RandMorty
//
//  Created by Максим Сулим on 17.08.2023.
//

import UIKit

class EpisodesCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureDef()
    }
    
    weak var delegate: EpisodeProtocol?
    
    func configureDef() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.contentView.backgroundColor = Resources.Color.blackBackGround
        collectionView.backgroundColor = Resources.Color.blackBackGround
        collectionView.collectionViewLayout = configureCollectionLayout()
    }

    private func configureCollectionLayout() -> UICollectionViewCompositionalLayout {
        
        
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(86))
        
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        
        let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupLayoutSize, subitems: [item])
        group.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 16, leading: 8, bottom: 16, trailing: 8)
        
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}


extension EpisodesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.episodesModel.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodesCollectionCell", for: indexPath) as! EpisodesCollectionCell
        
        
        let name = delegate?.episodesModel[indexPath.row].name
        let number = (delegate?.episodesModel[indexPath.row].number.transformNumberEpisode())!
        let date = delegate?.episodesModel[indexPath.row].date
    
        cell.configure(with: EpisodesCollectionCell.EpisodeViewModel(name: name!, number: number, date: date!))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
}
