//
//  FavoriteVC.swift
//  YourApp
//
//  Created by J C on 2020-12-13.
//

import UIKit

class FavoriteVC: UIViewController, UIPageViewControllerDataSource {
    let galleries: [String] = ["1", "2", "3", "4", "5", "6", "7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sp = SinglePage(gallery: galleries[0])
        
        let pvc = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pvc.setViewControllers([sp], direction: .forward, animated: false, completion: nil)
        pvc.dataSource = self
        
        addChild(pvc)
        self.view.addSubview(pvc.view)
        pvc.view.frame = self.view.bounds
        pvc.didMove(toParent: self)
        
        let proxy = UIPageControl.appearance()
        proxy.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.6)
        proxy.currentPageIndicatorTintColor = .black
        proxy.backgroundColor = .clear
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let gallery = (viewController as! SinglePage).gallery, var index = galleries.firstIndex(of: gallery) else { return nil }
        index -= 1
        if index < 0 {
            return nil
        }
        return SinglePage(gallery: galleries[index])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let gallery = (viewController as! SinglePage).gallery, var index = galleries.firstIndex(of: gallery) else { return nil }
        index += 1
        if index >= galleries.count {
            return nil
        }
        return SinglePage(gallery: galleries[index])
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.galleries.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        let page = pageViewController.viewControllers![0] as! SinglePage
        let gallery = page.gallery!
        return self.galleries.firstIndex(of: gallery)!
    }
}

class PageViewController: UIPageViewController {
    
}

class SinglePage: UIViewController {
    var gallery: String!
    
    init(gallery: String) {
        self.gallery = gallery
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let size = UIScreen.main.bounds.size
        let image = UIImage(named: "\(gallery ?? "1").jpg")!
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width, height: size.height)))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        self.view.addSubview(imageView)
    }
}
