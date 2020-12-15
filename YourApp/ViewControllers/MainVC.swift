//
//  ViewController.swift
//  YourApp
//
//  Created by J C on 2020-11-09.
//

import UIKit

class MainVC: UIViewController {
    var mainScrollView = UIScrollView()
    let size = CGSize(width: 150, height: 150)
    lazy var bounds = CGRect(origin: .zero, size: size)
    
    lazy var cards: [UIView] = {
        var cards = [UIView]()
        for index in 1...10 {
            let card = self.createImage(index: index, isCircular: false)
            cards.append(card)
        }
        return cards
    }()

    lazy var circleCards: [UIView] = {
        var cards = [UIView]()
        for index in 3...7 {
            let card = self.createImage(index: index, isCircular: true)
            cards.append(card)
        }
        return cards
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mainScrollView)
        self.mainScrollView.translatesAutoresizingMaskIntoConstraints = false

        let hScrollView1 = setupScrollView(with: Array(cards[1...4]), title: "Top Picks")
        let hScrollView2 = setupScrollView(with: Array(cards[5...9]), title: "Recently Played")
        let hScrollView3 = setupScrollView(with: Array(circleCards[1...4]), title: "New Releases")
        
        NSLayoutConstraint.activate([
            // main scrollview
            self.mainScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mainScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mainScrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            self.mainScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            // hScrollView1
            hScrollView1.topAnchor.constraint(equalTo: self.mainScrollView.topAnchor),
            hScrollView1.widthAnchor.constraint(equalTo: self.mainScrollView.widthAnchor),
            hScrollView1.heightAnchor.constraint(equalToConstant: 200),
            
            // hScrollView2
            hScrollView2.topAnchor.constraint(equalTo: hScrollView1.bottomAnchor, constant: 50),
            hScrollView2.widthAnchor.constraint(equalTo: self.mainScrollView.widthAnchor),
            hScrollView2.heightAnchor.constraint(equalToConstant: 200),
            
            // hScrollView3
            hScrollView3.topAnchor.constraint(equalTo: hScrollView2.bottomAnchor, constant: 50),
            hScrollView3.widthAnchor.constraint(equalTo: self.mainScrollView.widthAnchor),
            hScrollView3.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        self.mainScrollView.contentSize = CGSize(width: self.view.bounds.width, height: 1000)
    }
    
    @objc func tapped(_ sender: UIGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        let location = sender.location(in: tappedView)
        let playerVC = PlayerVC(tag: tappedView.tag, tappedViewFrame: tappedView, tappedLocation: location, window: self.view.window!, gestureName: sender.name ?? "")
        self.present(playerVC, animated: true, completion: nil)
    }
    
    func setupScrollView(with cards: [UIView], title: String) -> UIView {
        let containerView = UIView()
        self.mainScrollView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)
        
        let hScrollView = UIScrollView()
        containerView.addSubview(hScrollView)
        hScrollView.translatesAutoresizingMaskIntoConstraints = false
        hScrollView.showsHorizontalScrollIndicator = false
        
        let stackView = UIStackView(arrangedSubviews: cards)
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20
        hScrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // label
            label.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            label.heightAnchor.constraint(equalToConstant: 50),
            label.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            // hScrollView
            hScrollView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            hScrollView.heightAnchor.constraint(equalToConstant: 150),
            hScrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            // stackView
            stackView.heightAnchor.constraint(equalTo: hScrollView.heightAnchor),
            stackView.leadingAnchor.constraint(equalTo: hScrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: hScrollView.trailingAnchor),
        ])
        
        return containerView
    }
    
    
    func createImage(index: Int, isCircular: Bool) -> UIView {
        var finalImage: UIImage!
        let img = UIImage(named: "\(index).jpg")!
        
        if isCircular {
            let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
            finalImage = renderer.image { (_) in
                UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width).addClip()
                img.draw(in: bounds)
            }
        } else {
            finalImage = img
        }
        let imageView = UIImageView(image: finalImage)
        imageView.contentMode = .scaleAspectFill
        
        let card = UIView()
        card.tag = index
        card.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tap.name = GestureNames.normal
        card.addGestureRecognizer(tap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.name = GestureNames.enlarge
        card.addGestureRecognizer(doubleTap)
        
        card.addSubview(imageView)
        card.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalToConstant: 150),
            card.widthAnchor.constraint(equalToConstant: 150),
            
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
        ])
        return card
    }
}

