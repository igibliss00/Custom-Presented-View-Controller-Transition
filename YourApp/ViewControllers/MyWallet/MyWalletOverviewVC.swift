//
//  MyWalletOverviewVC.swift
//  YourApp
//
//  Created by J C on 2021-01-17.
//

import UIKit

struct CardData {
    let bankName: String
    let balance: String
    let cardNumber: String
    let backgroundColor: UIColor
}


class MyWalletOverviewVC: UIViewController {
    let data = [
        CardData(bankName: "RBC Bank", balance: "$2.320", cardNumber: "3423", backgroundColor: UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 1)),
        CardData(bankName: "TD Bank", balance: "$3.50", cardNumber: "2389", backgroundColor: UIColor(red: 51/255, green: 255/255, blue: 51/255, alpha: 1)),
        CardData(bankName: "Tangerine", balance: "$3983.20", cardNumber: "9482", backgroundColor: UIColor(red: 153/255, green: 51/255, blue: 255/255, alpha: 1)),
        CardData(bankName: "Scotiabank", balance: "$1294.50", cardNumber: "3921", backgroundColor: UIColor(red: 255/255, green: 51/255, blue: 255/255, alpha: 1))
    ]
    
    var scrollView: UIScrollView!
    var dataSource: UICollectionViewDiffableDataSource<SectionLayoutKind, Int>! = nil
    var collectionView: UICollectionView! = nil
    
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
        configureCardUI()
        setConstraints()
    }
    
    func configureCardUI() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
}

// MARK: - collection view layout

extension MyWalletOverviewVC {
    enum SectionLayoutKind: Int, CaseIterable {
        case horizontal, vertical
        var orientation: String {
            switch self {
                case .horizontal:
                    return "horizontal"
                case .vertical:
                    return "vertical"
            }
        }
    }
    
    func configureHierarchy() {
        //        func createLayout() -> UICollectionViewLayout {
        //            let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
        //                guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }
        //                let orientation = sectionLayoutKind.orientation
        //
        //                if orientation == "horizontal" {
        //                    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(<#T##fractionalWidth: CGFloat##CGFloat#>), heightDimension: <#T##NSCollectionLayoutDimension#>)
        //                } else {
        //
        //                }
        //
        //            }
        //        }
    }
    
    func configureDataSource() {
        
    }
}


class Card: UIView {
    
    init() {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    func configureUI() {
        self.layer.cornerRadius = self.bounds.width / 2
    }
}
