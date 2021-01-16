//
//  AppDataTypes.swift
//  YourApp
//
//  Created by J C on 2020-12-14.
//

import UIKit

struct GestureNames {
    static let enlarge = "enlarge"
    static let normal = "normal"
    static let longPress = "longPress"
}

struct CellNames {
    static let cell = "cell"
    static let customCell = "customCell"
}

struct AnimationName {
    static let customTransitionVC = "CustomTransitionVC"
    static let prgr = "Pinch Rotate Gesture Recognizer"
    static let snap = "UISnapBehavior"
    static let scroll = "Scroll View Zoom"
    static let page = "Page"
    static let autoScroll = "Auto Scroll"
    static let customTable = "Custom Table"
    static let gps = "GPS"
    static let carousal = "Carousal"
    static let dynamic = "Dynamic"
    static let activity = "Activity"
    static let basicAVCompVC = "Basic AVComposition"
    static let videoEdit = "Video Edit"
    static let sideMenu = "Side Menu"
    static let myWallet = "My Wallet"
}

struct MenuData {
    let imageName: String
    let title: String
    let subTitle: String
    let price: String
}

struct MenuDataKey {
    static let imageName = "imageName"
    static let title = "title"
    static let subTitle = "subTitle"
    static let price = "price"
}

// HeroView, HorizontalHeroView
class Wrapper<T> {
    var wrappedValue: T
    init(for value:T) {
        self.wrappedValue = value
    }
}

protocol Transferable {
    var constant: CGFloat { get set }
    var attribute: NSLayoutConstraint.Attribute { get }
    var relatedBy: NSLayoutConstraint.Relation { get }
}

struct TransferableConstrainst: Transferable {
    var attribute: NSLayoutConstraint.Attribute
    let relatedBy: NSLayoutConstraint.Relation
    let attribute2: NSLayoutConstraint.Attribute
    let multiplier: CGFloat
    var constant: CGFloat
}

struct TransferableConstantAnchor: Transferable {
    let attribute: NSLayoutConstraint.Attribute
    var constant: CGFloat
    var relatedBy: NSLayoutConstraint.Relation
}
