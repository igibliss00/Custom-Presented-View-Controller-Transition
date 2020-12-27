//
//  AnimationsViewController.swift
//  YourApp
//
//  Created by J C on 2020-12-23.
//

import UIKit

class AnimationsVC: UITableViewController {
    let data = [AnimationName.prgr, AnimationName.snap, AnimationName.scroll, AnimationName.page, AnimationName.autoScroll, AnimationName.customTable, AnimationName.gps]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.cell, for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = data[indexPath.row]
        switch title {
            case AnimationName.prgr:
                let pinchVC = PinchVC()
                self.navigationController?.pushViewController(pinchVC, animated: true)
            case AnimationName.snap:
                let snapVC = SnapVC()
                self.navigationController?.pushViewController(snapVC, animated: true)
            case AnimationName.page:
                let pageVC = PageVC()
                self.navigationController?.pushViewController(pageVC, animated: true)
            case AnimationName.scroll:
                let scrollVC = ScrollVC()
                self.navigationController?.pushViewController(scrollVC, animated: true)
            case AnimationName.autoScroll:
                let autoScroll = AutoScrollVC()
                self.navigationController?.pushViewController(autoScroll, animated: true)
            case AnimationName.customTable:
                let customTableVC = CustomTableVC()
                self.navigationController?.pushViewController(customTableVC, animated: true)
            case AnimationName.gps:
                let gpsVC = GpsVC()
                self.navigationController?.pushViewController(gpsVC, animated: true)
            default:
                break
        }
    }
}
