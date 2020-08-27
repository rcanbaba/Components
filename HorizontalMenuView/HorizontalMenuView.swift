//
//  HorizontalMenuView.swift
//  PaycellUIKit
//
//  Created by RECEP CAN BABAOGLU on 23.07.2020.
//  Copyright © 2020 BARAN BATUHAN KARAOGUZ. All rights reserved.
//

import Foundation
import UIKit
import PaycellCore

public protocol HorizontalMenuDelegate: class {
    func didSelectMenuItem(menuIndex:MenuIndex, selectedIndex:IndexPath)
}

public final class HorizontalMenuView: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    private var menuType: MenuType!
    public  var delegate: HorizontalMenuDelegate?
    private var menuProperties:HorizontalMenuAttributes!
    private var didAutoScroll = false
    
    lazy var menuCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        if #available(iOS 10.0, *){
            layout.itemSize = UICollectionViewFlowLayout.automaticSize
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }else{
            layout.itemSize = CGSize(width: 1.7976931348623157e+308, height: 1.7976931348623157e+308)
            layout.estimatedItemSize = layout.itemSize
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.tag = self.menuProperties.menuIndex.rawValue
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    public required init(coder: NSCoder){
        super.init(coder: coder)!
    }
    
    public init(type: MenuType, menuArray: [String]){
        super.init(frame: .zero)
        self.menuType = type
        let MenuProperties = HorizontalMenuAttributes(menuIndex: .first, selectedIndex: 0, menuTitles: menuArray)
        self.menuProperties = MenuProperties
        viewSetup()
    }
    
    private func viewSetup(){
        viewRemove()
        menuCollection.registerCell(HorizontalMenuCell.self)
        menuCollection.delegate = self
        let underlineBar = UIView()
        underlineBar.backgroundColor = menuProperties.underlineBarColor
        self.addSubview(underlineBar)
        underlineBar.translatesAutoresizingMaskIntoConstraints = false
        underlineBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.5).isActive = true
        underlineBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        underlineBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        underlineBar.heightAnchor.constraint(equalToConstant:2).isActive = true
        self.addSubview(menuCollection)
        self.menuCollection.heightAnchor.constraint(equalToConstant:50).isActive = true
        self.menuCollection.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.menuCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.menuCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.menuCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.menuCollection.clipsToBounds = true
    }
    
    private func viewRemove(){
        for view in self.subviews{
            if view.tag == self.menuProperties.menuIndex.rawValue{
                view.removeFromSuperview()
            }
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuProperties.menuTitles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollection.dequeueCell(HorizontalMenuCell.self, for: indexPath)
            cell.create(indexPath: indexPath, isSelected: false, menuProperties: self.menuProperties)
            return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !self.didAutoScroll{
           // menuCollection.scrollToItem(at: Index, at: .left, animated: false)
            self.didAutoScroll = true
        }
    }

}
