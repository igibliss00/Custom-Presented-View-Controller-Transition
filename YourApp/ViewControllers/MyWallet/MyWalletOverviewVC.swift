//
//  MyWalletOverviewVC.swift
//  YourApp
//
//  Created by J C on 2021-01-17.
//

import UIKit

class MyWalletOverviewVC: UIViewController {
    enum SectionLayoutKind: Int, CaseIterable {
        case cardData, listData
        var section: String {
            switch self {
                case .cardData:
                    return "Card Data"
                case .listData:
                    return "List Data"
            }
        }
    }
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    let myWalletDataController = MyWalletDataController()
    var dataSource: UICollectionViewDiffableDataSource<MyWalletDataController.WalletSection, MyWalletDataController.WalletData>! = nil
    var collectionView: UICollectionView! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<MyWalletDataController.WalletSection, MyWalletDataController.WalletData>! = nil
    
    private func calculatePreferredSize() {
        let targetSize = CGSize(width: view.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }
    
    override func loadView() {
        let v = UIView()
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        v.backgroundColor = .systemBackground
        view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
    }
    
    // resize the parent vc according to this current vc
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calculatePreferredSize()
    }

}

// MARK: - collection view layout

extension MyWalletOverviewVC {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }
            let sectionType = sectionLayoutKind.section

            var group: NSCollectionLayoutGroup!
            if sectionType == "Card Data" {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(150))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.interGroupSpacing = 20
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: MyWalletOverviewVC.sectionHeaderElementKind, alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: MyWalletOverviewVC.sectionHeaderElementKind, alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            }
        }
        
        return layout
    }
}

// MARK:- hierarchy, data source

extension MyWalletOverviewVC {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    func configureDataSource() {
        let cardCellRegistration = UICollectionView.CellRegistration<CardCustomCell, MyWalletDataController.CardData>{ (cell, indexPath, cards) in
            // title
            let content = NSMutableAttributedString(string: cards.title)
            
            let attributedAttachment = NSMutableAttributedString()
            if let image = UIImage.init(systemName: cards.isIncreased ? "arrow.up" : "arrow.down") {
                attributedAttachment.addImageAttachment(image: image, font: .systemFont(ofSize: 40), textColor: cards.isIncreased ? .cyan : .red)
            }
            
            content.insert(attributedAttachment, at: 0)
            cell.titleLabel.attributedText = content
            
            // subtitle
            cell.subtitleLabel.text = cards.subTitle
        }
        
        let listCellRegistration = UICollectionView.CellRegistration<ListCustomCell, MyWalletDataController.ListData> { (cell, indexPath, lists) in
            cell.vendorLabel.text = lists.vendor
            cell.dateLabel.text = lists.date
            cell.amountLabel.text = lists.amount
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: MyWalletOverviewVC.sectionHeaderElementKind) { (supplementaryView, string, indexPath) in
            if let snapshot = self.currentSnapshot {
                let walletCategory = snapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.label.text = walletCategory.title
                supplementaryView.label.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
                supplementaryView.label.textColor = .lightGray
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource<MyWalletDataController.WalletSection, MyWalletDataController.WalletData>(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, walletData: MyWalletDataController.WalletData) -> UICollectionViewCell? in
            return SectionLayoutKind(rawValue: indexPath.section)! == .cardData ?
                collectionView.dequeueConfiguredReusableCell(using: cardCellRegistration, for: indexPath, item: walletData as? MyWalletDataController.CardData) :
                collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: walletData as? MyWalletDataController.ListData)
        })
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
        
        currentSnapshot = NSDiffableDataSourceSnapshot<MyWalletDataController.WalletSection, MyWalletDataController.WalletData>()
        myWalletDataController.data.forEach {
            let section = $0
            currentSnapshot.appendSections([section])
            currentSnapshot.appendItems(section.walletData)
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}

// MARK:- didSelectItemAt

extension MyWalletOverviewVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
