//
//  CarousalVC.swift
//  YourApp
//
//  Created by J C on 2020-12-29.
//

import UIKit

class CarousalVC: UIViewController {
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
    
    override func loadView() {
        let v = UIView()
        v.backgroundColor = .systemBackground
        view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
    }
}

extension CarousalVC {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.8))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // group
            let groupFractionalWidth = CGFloat(layoutEnvironment.container.effectiveContentSize.width > 500 ? 0.425 : 0.60)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth), heightDimension: .absolute(layoutEnvironment.container.effectiveContentSize.height))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 0, bottom: 100, trailing: 0)
            
            // section
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 30
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.visibleItemsInvalidationHandler = { items, offset, environment in
                let visibleFrame = CGRect(origin: offset, size: environment.container.contentSize)
                let cells = items.filter { $0.representedElementCategory == .cell }
                for item in cells {
                    let distanceFromCenter = abs(visibleFrame.midX - item.center.x)
                    let scaleZone = CGFloat(70)
                    let scaleFactor = distanceFromCenter / scaleZone
                    if distanceFromCenter < scaleZone {
                        let scale = 1 + 0.5 * (1 - abs(scaleFactor))
                        let transform = CGAffineTransform(scaleX: scale, y: scale)
                        item.transform = transform
                    }
                }
            }
            
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
}

extension CarousalVC {
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ProductCell, MyData> { (cell, indexPath, myData) in
            cell.imageView.image = myData.image
            cell.titleLabel.text = myData.title
            cell.subTitleLabel.text = myData.subTitle
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, MyData>(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath, myData: MyData) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: myData)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, MyData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(myDataCollection)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension CarousalVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0.0
    }
}

class ProductCell: UICollectionViewCell {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}

extension ProductCell {
    private func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.adjustsFontForContentSizeCategory = true
        subTitleLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        subTitleLabel.textColor = .placeholderText
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: inset),
            titleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

struct MyData: Hashable {
    let image: UIImage
    let title: String
    let subTitle: String
    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
