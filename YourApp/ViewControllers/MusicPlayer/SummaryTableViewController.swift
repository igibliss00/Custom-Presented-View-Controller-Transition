//
//  SummaryTableViewController.swift
//  YourApp
//
//  Created by J C on 2020-12-16.
//

import UIKit

class SummaryTableViewController: UITableViewController {
    var tag: Int!
    lazy var data: [[String]] = [
        [String(self.tag)],
        [
            "Sombody's Problem",
            "Show Me Around",
            "Stay Up",
            "Do What You Love",
            "Forever",
            "Under My Skin",
            "Front Seat"
        ]
    ]
    
    init(tag: Int) {
        self.tag = tag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            tableView.register(CustomCell.self, forCellReuseIdentifier: "customCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.customCell, for: indexPath) as! CustomCell
            let convertedTag = String(data[indexPath.section][indexPath.row])
            cell.set(tag: convertedTag)
            return cell
        } else {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.cell, for: indexPath)
            cell.textLabel?.text = data[indexPath.section][indexPath.row]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        if section == 0 {
            return nil
        } else {
            return "Songs"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else {
            return 40
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.tintColor = .white
    }
}

class CustomCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(tag: String) {
        let image = UIImage(named: "\(tag).jpg")
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        imageView.layer.cornerRadius = 20
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let artistTitle = UILabel()
        artistTitle.text = "Lee Brice"
        artistTitle.font = UIFont.boldSystemFont(ofSize: 25.0)
        self.contentView.addSubview(artistTitle)
        artistTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let albumLabel = UILabel()
        albumLabel.text = "Hey World"
        self.contentView.addSubview(albumLabel)
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // imageView
            imageView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            // artistTitle
            artistTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -10),
            artistTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            artistTitle.heightAnchor.constraint(equalToConstant: 50),
            
            // albumTitle
            albumLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 10),
            albumLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            albumLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
