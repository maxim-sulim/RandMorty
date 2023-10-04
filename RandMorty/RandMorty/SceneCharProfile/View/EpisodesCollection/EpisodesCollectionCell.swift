//
//  EpisodesCollectionCell.swift
//  RandMorty
//
//  Created by Максим Сулим on 17.08.2023.
//

import UIKit
import SnapKit

class EpisodesCollectionCell: UICollectionViewCell {
    
//MARK: - model
    
    struct EpisodeViewModel {
        var name: String
        var number: String
        var date: String
    }
    
//MARK: - isSelected
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
//MARK: - private propperties view
    
    //ограничение для расширенного состояния
    private var expendedConstraint: Constraint!
    //ограничение для сжатого состояния
    private var collapsedConstraint: Constraint!
    
    lazy private var mainContainer = UIView()
    lazy private var topContainer = UIView()
    lazy private var bottomContainer = UIView()
    
    lazy var collectionCharsView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Resources.Color.blackGrayBackGround
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
//MARK: - private property model
    
    private var nameEpisode: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Color.infoWhite
        return label
    }()
    
    private var numberEpisode: UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 13)
        label.font = font
        label.textColor = Resources.Color.poisonousGreen
        return label
    }()
    
    private var dateEpisode: UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 13)
        label.font = font
        label.textAlignment = .right
        label.textColor = Resources.Color.infoLightGray
        return label
    }()
    
// MARK: - initializator
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - public methods
    
    func configureCell(model: EpisodeViewModel) {
        
        nameEpisode.text = model.name
        numberEpisode.text = model.number.transformNumberEpisode()
        dateEpisode.text = model.date
        
    }
    
    private func updateAppearance() {
        
        collapsedConstraint.isActive = !isSelected
        expendedConstraint.isActive = isSelected
        
    }
    
    private func configureView() {
        
        collectionCharsView.register(CharFromEpizodeCell.self, forCellWithReuseIdentifier: CharFromEpizodeCell.description())
        mainContainer.clipsToBounds = true
        mainContainer.layer.cornerRadius = 16
        topContainer.backgroundColor = Resources.Color.blackGrayBackGround
        bottomContainer.backgroundColor = .brown
        
        makeConstraints()
        updateAppearance()
        
    }
    
    private func makeConstraints() {
        
        setupContainerView()
        fillingTopContainer()
        fillingBottomContainer()
        
    }
    
    private func setupContainerView() {
        
        contentView.addSubview(mainContainer)
        
        mainContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainContainer.addSubview(topContainer)
        mainContainer.addSubview(bottomContainer)
        
        topContainer.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        
        //MARK: ограничение для сжатого состояния
        topContainer.snp.prepareConstraints { make in
            collapsedConstraint = make.bottom.equalToSuperview().constraint
            collapsedConstraint.layoutConstraints.first?.priority = .defaultLow
        }
        
        bottomContainer.snp.makeConstraints { make in
            make.top.equalTo(topContainer.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        //MARK: ограничение для расширенного состояния
        bottomContainer.snp.prepareConstraints { make in
            expendedConstraint = make.bottom.equalToSuperview().constraint
            expendedConstraint.layoutConstraints.first?.priority = .defaultLow
        }
        
    }
    
    private func fillingTopContainer() {
        
        let xStack = UIStackView()
        xStack.axis = .horizontal
        xStack.alignment = .center
        xStack.addArrangedSubview(numberEpisode)
        xStack.addArrangedSubview(dateEpisode)
        xStack.clipsToBounds = true
        xStack.distribution = .fillProportionally
        
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.addArrangedSubview(nameEpisode)
        yStack.addArrangedSubview(xStack)
        yStack.alignment = .leading
        yStack.spacing = 16
        
        topContainer.addSubview(yStack)
        
        
        yStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        xStack.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(0)
        }
        
    }
    
    private func fillingBottomContainer() {
        
        bottomContainer.addSubview(collectionCharsView)
        
        collectionCharsView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
}

extension EpisodesCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: CharFromEpizodeCell.description(), for: indexPath)
    }
    
}

extension EpisodesCollectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: Double = 70
        let height: Double = 50
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}
