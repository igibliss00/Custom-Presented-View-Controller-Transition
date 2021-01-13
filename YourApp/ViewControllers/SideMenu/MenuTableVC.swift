//
//  MenuTableVC.swift
//  YourApp
//
//  Created by J C on 2021-01-09.
//

import UIKit

struct Menu {
    let symbol: UIImage
    let title: String
}

enum MenuType: Int {
    case home
    case order
    case cart
    case logout
}

class MenuTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var customTableView: UITableView!
    let allMenu: [Menu] = [
        Menu(symbol: UIImage(systemName: "pin.circle.fill")!.withRenderingMode(.alwaysOriginal), title: "Home"),
        Menu(symbol: UIImage(systemName: "doc.fill.badge.plus")!.withRenderingMode(.alwaysOriginal), title: "Order"),
        Menu(symbol: UIImage(systemName: "memories.badge.plus")!.withRenderingMode(.alwaysOriginal), title: "Cart"),
        Menu(symbol: UIImage(systemName: "arrowshape.turn.up.backward.circle.fill")!.withRenderingMode(.alwaysOriginal), title: "Logout")
    ]
    var didTapMenuType: ((MenuType) -> Void)?
    
    override func loadView() {
        customTableView = UITableView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)), style: .plain)
        customTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        customTableView.backgroundColor = .systemBackground
        customTableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        view = customTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        customTableView.separatorStyle = .none
        customTableView.isScrollEnabled = false
        
        customTableView.delegate = self
        customTableView.dataSource = self
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let menu = allMenu[indexPath.row]
        cell.imageView!.image = menu.symbol
        cell.textLabel!.text = menu.title
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            self?.didTapMenuType?(menuType)
        }
    }
}
