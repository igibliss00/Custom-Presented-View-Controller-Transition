//
//  DynamicCollectionVC.swift
//  YourApp
//
//  Created by J C on 2020-12-29.
//

import UIKit

class DynamicCollectionVC: UIViewController {
    // section
    enum Section {
        case main
    }
    
    // items
    var myDataCollection: [MyData] {
        var myDataCollection = [MyData]()
        for i in 1..<10 {
            let myData = MyData(image: UIImage(named: "\(i).jpg")!,title: "Title: \(i)", subTitle: "SubTitle: \(i)")
            myDataCollection.append(myData)
        }
        return myDataCollection
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, MyData>! = nil
    var collectionView: UICollectionView! = nil
    var anim: UIDynamicAnimator?
    
    override func loadView() {
        let v = UIView()
        v.backgroundColor = .systemBackground
        view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(doFlush(_:)))
        navigationItem.rightBarButtonItem = button
        configureHierarchy()
        configureDataSource()
    }
    
    
    @objc func doFlush(_ sender: UIBarButtonItem) {
        guard let cv = self.collectionView else { return }
        let layout = cv.collectionViewLayout
        let anim = UIDynamicAnimator(collectionViewLayout: layout)
        var attributes = [UICollectionViewLayoutAttributes]()
        for indexPath in cv.indexPathsForVisibleItems {
            if let attribute = cv.layoutAttributesForItem(at: indexPath) {
                let behaviour = UIDynamicItemBehavior(items: [attribute])
                behaviour.resistance = CGFloat.random(in: 0.2...6)
                behaviour.addAngularVelocity(CGFloat.random(in: -2...2), for: attribute)
                anim.addBehavior(behaviour)
                attributes.append(attribute)
            }
            
            let gravity = UIGravityBehavior(items: attributes)
            gravity.action = { [unowned self] in
                let items = anim.items(in: self.collectionView.bounds)
                if items.count == 0 {
                    anim.removeAllBehaviors()
                    self.anim = nil
                }
            }
            
            anim.addBehavior(gravity)
            self.anim = anim
        }
    }
}

extension DynamicCollectionVC {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        section.visibleItemsInvalidationHandler = {[unowned self] items, _, _ in
            if let anim = self.anim {
                for item in items {
                    if let attributes = anim.layoutAttributesForCell(at: item.indexPath) {
                        item.center = attributes.center
                        item.transform3D = attributes.transform3D
                    }

                }
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        return layout
    }
}

extension DynamicCollectionVC {
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ProductCell, MyData> { (cell, indexPath, myData) in
            cell.imageView.image = myData.image
            cell.titleLabel.text = myData.title
            cell.subTitleLabel.text = myData.subTitle
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, MyData>(collectionView: self.collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, myData: MyData) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: myData)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, MyData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(myDataCollection)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
