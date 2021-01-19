//
//  WalletDetailVC.swift
//  YourApp
//
//  Created by J C on 2021-01-18.
//

import UIKit

class WalletDetailVC: UIViewController {
    enum SectionLayoutKind: Int, CaseIterable {
        case creditCardData, listData
        var section: String {
            switch self {
                case .creditCardData:
                    return "Credit Card Data"
                case .listData:
                    return "List Data"
            }
        }
    }
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    let myWalletDataController = MyWalletDataController(dataCategory: .detail)
    var dataSource: UICollectionViewDiffableDataSource<MyWalletDataController.WalletSection, MyWalletDataController.WalletData>! = nil
    var collectionView: UICollectionView! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<MyWalletDataController.WalletSection, MyWalletDataController.WalletData>! = nil
    var layoutType = 1
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(tapHandler), name: .CreditCardTapped, object: nil)
        
        configureNavigationBar()
        configureHierarchy()
        configureDataSource()
    }
    
    func configureNavigationBar() {
        view.insetsLayoutMarginsFromSafeArea = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        self.title = "My Wallet"
    }
    
    @objc func tapHandler() {
        var snapshot = dataSource.snapshot()
        var modifiableListSection = [MyWalletDataController.WalletSection]()
        if layoutType == 1 {
            layoutType = 2
            for section in myWalletDataController.data {
                if section.title == "Overview" {
                    modifiableListSection.append(section)
                }
            }
            snapshot.deleteSections(modifiableListSection)
        } else {
            layoutType = 1
            currentSnapshot.deleteAllItems()
            myWalletDataController.data.forEach {
                let section = $0
                currentSnapshot.appendSections([section])
                currentSnapshot.appendItems(section.walletData)
            }
        }

        dataSource.apply(snapshot, animatingDifferences: false) {
            DispatchQueue.main.async {
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(self.createLayout(with: self.layoutType), animated: true, completion: nil)
//                self.collectionView.layoutIfNeeded()
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - collection view layout

extension WalletDetailVC {
    func createLayout(with layoutType: Int = 1) -> UICollectionViewLayout {
        var layout: UICollectionViewCompositionalLayout!
        switch layoutType {
            case 1:
                layout = detailLayout()
            case 2:
                layout = cardsOnlyLayout()
            default:
                break
        }

        return layout
    }
    
    private func detailLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }
            let sectionType = sectionLayoutKind.section
            
            if sectionType == "Credit Card Data" {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalHeight(0.25))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.interGroupSpacing = 20
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 2
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                
                return section
            }
        }
        return layout
    }
    
    private func cardsOnlyLayout() -> UICollectionViewCompositionalLayout {
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//            guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }
//            let sectionType = sectionLayoutKind.section
            
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        section.visibleItemsInvalidationHandler = { (visibleItems, offset, env) in
            let normalizedOffsetX = offset.x
            let centerPoint = CGPoint(x: normalizedOffsetX + self.collectionView.bounds.width / 2, y: 20)
            visibleItems.forEach({ item in
                guard let cell = self.collectionView.cellForItem(at: item.indexPath) else { return }
                UIView.animate(withDuration: 0.3) {
                    cell.transform = item.frame.contains(centerPoint) ? .identity : CGAffineTransform(scaleX: 0.9, y: 0.9)
                }
            })
        }
        
//            return section
            
//            if sectionType == "Credit Card Data" {
//                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//
//                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
//
//                let section = NSCollectionLayoutSection(group: group)
//                section.interGroupSpacing = 20
//                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
//
//                return section
//            } else {
//                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//
//                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
//
//                let section = NSCollectionLayoutSection(group: group)
//                section.interGroupSpacing = 2
//                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
//
//                return section
//            }
//        }
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK:- hierarchy, data source

extension WalletDetailVC {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout(with: layoutType))
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    func configureDataSource() {
        let cardCellRegistration = UICollectionView.CellRegistration<CreditCardCell, MyWalletDataController.CreditCardData>{ (cell, indexPath, cards) in
            cell.titleLabel.text = cards.title
            cell.expiryLabel.text = cards.expire
            
            // background color and gradient
            let startingColor1 = UIColor(red: 175/255, green: 122/255, blue: 197/255, alpha: 1)
            let finishingColor1 = UIColor(red: 215/255, green: 189/255, blue: 226/255, alpha: 1)
            let startingColor2 = UIColor(red: 117/255, green: 121/255, blue: 231/255, alpha: 1)
            let finishingColor2 = UIColor(red: 160/255, green: 163/255, blue: 239/255, alpha: 1)
            let colorArr = [(startingColor1, finishingColor1), (startingColor2, finishingColor2)]
            let color = colorArr[indexPath.item]
            cell.backgroundColor = color.0
            cell.startingColor = color.0.cgColor
            cell.finishingColor = color.1.cgColor
        }
        
        let listCellRegistration = UICollectionView.CellRegistration<ListCustomCell, MyWalletDataController.ListData> { (cell, indexPath, lists) in
            cell.vendorLabel.text = lists.vendor
            cell.dateLabel.text = lists.date
            cell.amountLabel.text = lists.amount
            cell.layer.shadowOpacity = 0.2
        }

        dataSource = UICollectionViewDiffableDataSource<MyWalletDataController.WalletSection, MyWalletDataController.WalletData>(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, walletData: MyWalletDataController.WalletData) -> UICollectionViewCell? in
            return SectionLayoutKind(rawValue: indexPath.section)! == .creditCardData ?
                collectionView.dequeueConfiguredReusableCell(using: cardCellRegistration, for: indexPath, item: walletData as? MyWalletDataController.CreditCardData) :
                collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: walletData as? MyWalletDataController.ListData)
        })

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

extension WalletDetailVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
