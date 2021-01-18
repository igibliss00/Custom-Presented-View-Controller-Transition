//
//  MyWalletDataController.swift
//  YourApp
//
//  Created by J C on 2021-01-18.
//

//protocol WalletData {
//    var identifier: UUID { get }
//}

import Foundation

class MyWalletDataController {
    struct WalletSection: Hashable {
        let identifier: UUID = UUID()
        let title: String
        let walletData: [WalletData]
        
        func hash(into hasher: inout Hasher) {
            return hasher.combine(identifier)
        }
        
        static func == (lhs: WalletSection, rhs: WalletSection) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    }
    
    class WalletData: Hashable {
        let identifier: UUID = UUID()
        
        func hash(into hasher: inout Hasher) {
            return hasher.combine(identifier)
        }
        
        static func == (lhs: WalletData, rhs: WalletData) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    }
    
    class CardData: WalletData {
        var title: String!
        var subTitle: String!
        var isIncreased: Bool!
        
        init(title: String, subTitle: String, isIncreased: Bool) {
            self.title = title
            self.subTitle = subTitle
            self.isIncreased = isIncreased
        }
    }
    
    class ListData: WalletData {
        var vendor: String!
        var date: String!
        var amount: String!
        var isIncreased: Bool!
        
        init(vendor: String, date: String, amount: String, isIncreased: Bool) {
            self.vendor = vendor
            self.date = date
            self.amount = amount
            self.isIncreased = isIncreased
        }
    }

    var data: [WalletSection] {
        return _data
    }
    
    init() {
        generateData()
    }
    
    fileprivate var _data = [WalletSection]()
}

extension MyWalletDataController {
    func generateData() {
        _data = [
            WalletSection(title: "Payment Info",
                          walletData: [CardData(title: "$153.50", subTitle: "Revenue", isIncreased: true),
                                       CardData(title: "$79.50", subTitle: "Expense", isIncreased: false)]),
            WalletSection(title: "Overview", walletData: [ListData(vendor: "Starbucks Coffee", date: "Today 09:12 AM", amount: "$153.50", isIncreased: false),
                                                          ListData(vendor: "PayPal Transfer ", date: "January 11, 2021", amount: "$600.00", isIncreased: true),
                                                          ListData(vendor: "7-Eleven", date: "January 09, 2021", amount: "$76.30", isIncreased: false),
                                                          ListData(vendor: "Apple Store", date: "January 08, 2021", amount: "12.00", isIncreased: false),
                                                          ListData(vendor: "Walmart", date: "January 08, 2021", amount: "$88.30", isIncreased: false),
                                                          ListData(vendor: "Bank of America", date: "January 05, 2021", amount: "$1325.00", isIncreased: true),
                                                          ListData(vendor: "Mastercard", date: "January 04, 2021", amount: "$129.15", isIncreased: true),
                                                          ListData(vendor: "iTunes Store", date: "January 02, 2021", amount: "$39.96", isIncreased: false)])
        ]

    }
}
