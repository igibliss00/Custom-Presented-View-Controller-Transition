//
//  SideMenuVC.swift

//  YourApp
//
//  Created by J C on 2021-01-09.
//

import UIKit
class SideMenuVC: UIViewController, SegmentedControlDelegate {
    let menuDataDict: [String: [MenuData]] = [
        "Salads": [
            MenuData(imageName: "salad.png", title: "Chicken Salad", subTitle: "Chicken with Avocado", price: "$32.00"),
            MenuData(imageName: "salad2.png", title: "Mixed Salad", subTitle: "Mixed Vegetables", price: "$24.00"),
            MenuData(imageName: "salad3.png", title: "Quinoa Salad", subTitle: "Spicey with Garlic", price: "$22.00")
        ],
        "Soups": [
            MenuData(imageName: "soup2.png", title: "Carrot Ginger", subTitle: "Smoke Paprika", price: "$22.00"),
            MenuData(imageName: "soup3.png", title: "Butternut Squash", subTitle: "Ginder, Rosmary, Sage", price: "$18.00"),
            MenuData(imageName: "soup.png", title: "Creamy Potato", subTitle: "Healthy Comfort Food", price: "$14.00")
        ],
    ]
    
    let slideInTransitionAnimator = SlideInTransitionAnimator()
    let detailMenuAnimator = DetailMenuAnimator()
    var label: UILabel!
    var subLabel: UILabel!
    var sc: CustomSegmentedControl!
    var pageVC: UIViewController!
    var transitionType = 1
    
    override func loadView() {
        let v = UIView()
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        v.backgroundColor = .systemBackground
        view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(customViewTapped), name: .CustomViewTapped, object: nil)
        
        configureUI()
        configurePageVC()
        configureMenuBar()
        setConstraints()
    }
    
    func configureUI() {
        // left bar button
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(menuPressed))
        navigationItem.leftBarButtonItem = leftBarButton
        
        // right bar button
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightBarButton
        
        // navigation top bar colour
        let appearance = UINavigationBarAppearance()
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        
        // title label
        label = UILabel()
        label.text = "Dilicious Salads"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        // sub label
        subLabel = UILabel()
        subLabel.text = "We made fresh and healthy food"
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subLabel)
        
        // segmented control
        sc = CustomSegmentedControl(items: ["Salads", "Soups", "Grilled"])
        sc.delegate = self
        sc.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sc)
    }
    
    func configurePageVC() {
        guard let firstButton = sc.subviews[0].viewWithTag(1000) as? UIButton,
              let currentTitle = firstButton.currentTitle,
              let firstMenu = menuDataDict[currentTitle] else { return }
        pageVC = SingleMenuPageVC(menuData: firstMenu)
        
        addChild(pageVC)
        view.addSubview(pageVC.view)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        pageVC.didMove(toParent: self)
    }
    
    func configureMenuBar() {
        let menuBar = MenuBar()
        menuBar.layer.zPosition = 10
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuBar)
        menuBar.transform = CGAffineTransform(translationX: 0, y: 200)
        NSLayoutConstraint.activate([
            menuBar.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 50),
            menuBar.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10)
        ])
        
        let menuBarAnimation = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            menuBar.transform = .identity
        }
        menuBarAnimation.startAnimation()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // title label
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            // sub label
            subLabel.topAnchor.constraint(equalTo: label.layoutMarginsGuide.bottomAnchor, constant: 5),
            subLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            // custom segmented control
            sc.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 40),
            sc.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            sc.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            sc.heightAnchor.constraint(equalToConstant: 50),
            
            // page view controller 
            pageVC.view.topAnchor.constraint(equalTo: sc.layoutMarginsGuide.bottomAnchor, constant: 40),
            pageVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageVC.view.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    @objc func menuPressed() {
        self.navigationController?.definesPresentationContext = true
        transitionType = 1
        let menuTableVC = MenuTableVC()
        menuTableVC.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        menuTableVC.modalPresentationStyle = .overCurrentContext
        menuTableVC.transitioningDelegate = self
        self.present(menuTableVC, animated: true, completion: nil)
    }
    
    func transitionToNew(_ menuType: MenuType) {
        switch menuType {
            case .logout:
                self.navigationController?.popViewController(animated: true)
            default:
                break
        }
    }
    
    func segmentedControlDidChange(_ senderCurrentTitle: String) {
        guard let singleMenuData = menuDataDict[senderCurrentTitle] else { return }
        let newPageVC = SingleMenuPageVC(menuData: singleMenuData)
        addChild(newPageVC)
        newPageVC.view.alpha = 0
        pageVC.willMove(toParent: nil)
        pageVC.beginAppearanceTransition(false, animated: true)
        newPageVC.beginAppearanceTransition(true, animated: true)
        
        UIView.transition(from: pageVC.view, to: newPageVC.view, duration: 0.4, options: .transitionCrossDissolve) { (_) in
            self.pageVC.endAppearanceTransition()
            newPageVC.endAppearanceTransition()
            newPageVC.didMove(toParent: self)
            self.pageVC.removeFromParent()
            self.pageVC = newPageVC
            newPageVC.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                // page view controller
                self.pageVC.view.topAnchor.constraint(equalTo: self.sc.layoutMarginsGuide.bottomAnchor, constant: 40),
                self.pageVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.pageVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.pageVC.view.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            ])
            self.pageVC.view.alpha = 1
        }
    }
    
    @objc func customViewTapped() {
        transitionType = 2
        let detailVC = DetailMenuVC()
        self.present(detailVC, animated: true, completion: nil)
    }
}

extension SideMenuVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch transitionType {
            case 1:
                slideInTransitionAnimator.isPresenting = true
                return slideInTransitionAnimator
            case 2:
                return detailMenuAnimator
            default:
                return nil
        }

    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideInTransitionAnimator.isPresenting = false
        return slideInTransitionAnimator
    }
}

