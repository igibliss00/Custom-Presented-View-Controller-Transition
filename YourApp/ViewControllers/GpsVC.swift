//
//  gpsVC.swift
//  YourApp
//
//  Created by J C on 2020-12-27.
//

import UIKit
import MapKit

class GpsVC: UIViewController, UIPageViewControllerDataSource {
    var mapView: MKMapView!
    var data: [String] = {
        var data = [String]()
        for i in 0...5 {
            data.append("\(i+1). Turn right on Hollywood Blvd.")
        }
        return data
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = MKMapView()
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        // pageVC setup
        let cardVC = CardViewController(data: data[0])
        let pageVC = PageViewController1(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.setViewControllers([cardVC], direction: .forward, animated: false, completion: nil)
        pageVC.dataSource = self
        
        // container view for containment
        let containerView = UIView()
        view.addSubview(containerView)
        containerView.backgroundColor = .black
        
        // containment
        addChild(pageVC)
        containerView.addSubview(pageVC.view)
        pageVC.didMove(toParent: self)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // mapView
            mapView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            // container view
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            // pageVC
            pageVC.view.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            pageVC.view.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.6)
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.backgroundColor = .clear
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let info = (viewController as! CardViewController).label.text, var index = data.firstIndex(of: info)  else { return nil }
        index += 1
        if index > data.count {
            return nil
        }
        return CardViewController(data: data[index])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let info = (viewController as! CardViewController).label.text, var index = data.firstIndex(of: info) else { return nil }
        index -= 1
        if index < 0 {
            return nil
        }
        return CardViewController(data: data[index])
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return data.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        let pageVC = pageViewController.viewControllers![0] as! CardViewController
        let t = pageVC.label.text!
        return data.firstIndex(of: t)!
    }
}

class PageViewController1: UIPageViewController {
    
}

class CardViewController: UIViewController {
    var label: UILabel!
    var containerView: UIView!
    var iconView: IconView!
    
    init(data: String) {
        self.label = UILabel()
        self.label.text = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let v = UIView()
        v.backgroundColor = .black
        view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView = UIView()
        view.addSubview(containerView)
        
        // container view
        containerView.addSubview(label)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.textColor = .white
        label.numberOfLines = 0
        
        // icon view
        iconView = IconView()
        containerView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // containerView
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            // icon view
            iconView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4),
            iconView.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            // label
            label.leadingAnchor.constraint(equalTo: iconView.trailingAnchor),
            label.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
        ])
        
    }
}

class IconView: UIView {
    override func draw(_ rect: CGRect) {
        let circle = UIBezierPath(arcCenter: self.center, radius: 20, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        UIColor.orange.setFill()
        circle.fill()
    }
}

