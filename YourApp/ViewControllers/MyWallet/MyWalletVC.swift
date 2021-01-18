//
//  BillingMasterVC.swift
//  YourApp
//
//  Created by J C on 2021-01-16.
//

import UIKit

class MyWalletVC: UIViewController {
    var scrollView: UIScrollView!
    var heroView: TopHeroView!
    var stackView: UIStackView!
    
    override func loadView() {
        let v = UIView()
        v.backgroundColor = .systemBackground
        view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(topHerViewHandler), name: .TopHeroViewTapped, object: nil)
        
        configureNavigationBar()
        configureUI()
        setConstraints()
    }
    
    func configureNavigationBar() {
        view.insetsLayoutMarginsFromSafeArea = false
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureUI() {
        // scroll view
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: 800)
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        scrollView.contentInset = UIEdgeInsets(top: -topPadding, left: 0, bottom: 0, right: 0)
        view.addSubview(scrollView)
        
        // hero view
        heroView = TopHeroView()
        heroView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(heroView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // scroll view
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // hero view
            heroView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            heroView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            heroView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            heroView.heightAnchor.constraint(equalToConstant: 300),
            heroView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
        ])
    }
    
    @objc func topHerViewHandler() {
        self.navigationController?.popViewController(animated: true)
    }
}




//    func createBalanceLabelSeries(text: [String], previous: UIView?) -> (UILabel?, [NSLayoutConstraint]) {
////        guard let previous = previous else { return nil }
//        let previous = previous!
//        balanceLabelArr = [UILabel]()
//        var constraints = [NSLayoutConstraint]()
//        for i in 0...text.count - 1 {
////            let bl = createBalanceLabel(text: text[i])
//            let label = UILabel()
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.textColor = .white
//            label.text = text[i]
//            balanceMaskView.addSubview(label)
//
//            balanceLabelArr.append(label)
////            guard let index = balanceLabelArr.firstIndex(of: label) else { return nil }
//            let index = balanceLabelArr.firstIndex(of: label)!
//            constraints.append(label.topAnchor.constraint(equalTo: balanceMaskView.topAnchor))
//            constraints.append(label.widthAnchor.constraint(equalTo: balanceMaskView.widthAnchor, multiplier: 1/5))
//            if index == 0 {
//                print("prev", previous)
//                constraints.append(label.leadingAnchor.constraint(equalTo: previous.trailingAnchor))
//            } else {
//                constraints.append(label.leadingAnchor.constraint(equalTo: balanceLabelArr[index - 1].trailingAnchor))
//            }
//        }

//        NSLayoutConstraint.activate(constraints)
//        return (balanceLabelArr[balanceLabelArr.count - 1], constraints)
//    }
    
