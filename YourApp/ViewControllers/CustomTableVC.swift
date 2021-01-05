//
//  CustomTableVC.swift
//  YourApp
//
//  Created by J C on 2020-12-25.
//

import UIKit


struct CustomSection {
    var header: String
    var footer: String
    var detail: String
    var customData = [CustomData]()
    var index: String
}

struct CustomData {
    var title: String
}

class CustomTableVC: UITableViewController {
    var data = [CustomSection]()
    
    init() {
        super.init(style: .insetGrouped)
        for i in 0...4 {
            var customDataArr = [CustomData]()
            for q in 0...4 {
                let a = CustomData(title: "\(q)")
                customDataArr.append(a)
            }
            let c = CustomSection(header: "Header \(i)", footer: "Footer \(i)", detail: "Detail \(i)", customData: customDataArr, index: String(i))
            data.append(c)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomCell1.self, forCellReuseIdentifier: "cell")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "hfcell")
        
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // How to select multiple items
        self.tableView.allowsSelectionDuringEditing = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        
        // fully automatic cell resizing, combined with the intrinsic size
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        // manually refresh
        let leftButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(doRefresh))
        self.navigationItem.rightBarButtonItem = leftButton
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].customData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section].customData[indexPath.row].title
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return data[section].header
    //    }
    //
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return data[section].footer
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell: UITableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "hfcell")!
        if cell.textLabel?.text == nil && cell.detailTextLabel?.text == nil {
            cell.textLabel?.text = data[section].header
            cell.detailTextLabel?.text = data[section].detail
        }
        
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return data.map { $0.index }
    }
    
    // Setting how to behave when a cell is selected once or twice:
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if tableView.indexPathForSelectedRow == indexPath {
            tableView.deselectRow(at: indexPath, animated: true)
            return nil
        } else {
            // scrolls to the middle of the screen on every tap
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            return indexPath
        }
    }
    
    // How to use the accessoryType as a button
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let ac = UIAlertController(title: "Alert", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            let i = IndexPath(row: 3, section: 2)
            tableView.scrollToRow(at:  i, at: .middle, animated: true)
        }))
        present(ac, animated: true, completion: nil)
    }
    
    // manually refresh
    @objc func doRefresh(_ sender: UIBarButtonItem) {
        self.refreshControl!.sizeToFit()
        let top = self.tableView.adjustedContentInset.top
        let y = self.refreshControl!.frame.maxY + top
        self.tableView.setContentOffset(CGPoint(x: 0, y: -y), animated:true)
        self.refreshControl!.beginRefreshing()
        //        self.callTheFunction(self.refreshControl!)
    }
    
    // reordering
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let section = sourceIndexPath.section
        let sourceIndexPath = sourceIndexPath.row
        let destinationIndexPath = destinationIndexPath.row
        self.data[section].customData.swapAt(sourceIndexPath, destinationIndexPath)
        
    }
    
    // prevent re-ordering from going to other sections
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt srcip: IndexPath, toProposedIndexPath destip: IndexPath) -> IndexPath {
        if destip.section != srcip.section {
            return srcip
        }
        return destip
    }
    
    // animating the dropdown cell like the date picker from iOS Calendar
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 0) {
            self.toggleDatePickerCell()
        }
        
    }
    
    var showDatePicker = false
    func toggleDatePickerCell() {
        self.showDatePicker.toggle()
        self.tableView.performBatchUpdates(nil, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let myIndexPath = IndexPath(row: 1, section: 0)
        let cell: UITableViewCell? = tableView.cellForRow(at: myIndexPath) // this gets called over 100 times
        if indexPath == myIndexPath {
            //            return self.showDatePicker ? 200 : 0
            if self.showDatePicker {
                cell?.isHidden = false
                return 200
            } else {
                cell?.isHidden = true
                return 0
            }
        }
        
        return tableView.rowHeight
    }
    
    // long press to invoke a menu
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt ip: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier:nil, previewProvider: nil) { _ in
            let action = UIAction(title: "Copy") { _ in
                let state = self.data[ip.section].customData[ip.row]
                UIPasteboard.general.string = state.title
            }
            let menu = UIMenu(title: "", children: [action])
            return menu
        }
        return config
    }
    
    // Selecting Multiple Items with a Two-Finger Pan Gesture
    override func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        // Replace the Edit button with Done, and put the
        // table view into editing mode.
        self.setEditing(true, animated: true)
    }
    
    override func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
        print("\(#function)")
    }
    
}

class CustomCell1: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var internalHeight : CGFloat = 200 {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width:300, height:self.internalHeight)
    }
}
