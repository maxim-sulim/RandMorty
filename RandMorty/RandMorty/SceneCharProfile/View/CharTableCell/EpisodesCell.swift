//
//  EpisodesCell.swift
//  RandMorty
//
//  Created by Максим Сулим on 17.08.2023.
//

import UIKit

class EpisodesCell: UITableViewCell {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Resources.Color.blackBackGround
        view.showsVerticalScrollIndicator = false
        //позволяет выбрать сразу несколько ячеек
        view.allowsMultipleSelection = true
        view.alwaysBounceVertical = true
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTableCell()
    }
    
    private func configureTableCell() {
        
        contentView.backgroundColor = Resources.Color.blackBackGround
        contentView.addSubview(collectionView)
        collectionView.register(EpisodesCollectionCell.self,
                                forCellWithReuseIdentifier: EpisodesCollectionCell.description())
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    weak var delegate: EpisodeProtocol?
    
}


extension EpisodesCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.episodesModel.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodesCollectionCell.description(), for: indexPath) as! EpisodesCollectionCell
        
        let model = EpisodesCollectionCell.EpisodeViewModel(name: (delegate?.episodesModel[indexPath.row].name)!,
                                                            number: (delegate?.episodesModel[indexPath.row].number)!,
                                                            date: (delegate?.episodesModel[indexPath.row].date)!)
        cell.configureCell(model: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
}

extension EpisodesCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
        
        let width = collectionView.bounds.width - 40
        let height: Double = isSelected ? 170 : 70
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}

extension EpisodesCell: UICollectionViewDelegate {
    
    //переопределение метода для разворачивания ячейки
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        collectionView.selectItem(at: indexPath,
                                  animated: true,
                                  scrollPosition: [])
        collectionView.performBatchUpdates(nil)
        return true
    }
    
    //переопределение метода для сворачивания
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.performBatchUpdates(nil)
        return true
    }
    
}
