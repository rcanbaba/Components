//
//  HorizontalMenuCell.swift
//  PaycellUIKit
//
//  Created by RECEP CAN BABAOGLU on 24.07.2020.
//  Copyright © 2020 BARAN BATUHAN KARAOGUZ. All rights reserved.
//

import Foundation
import UIKit
import PaycellCore

class HorizontalMenuCell: UICollectionViewCell{
    
    private var menuProperties:HorizontalMenuAttributes!
    private var titleLabel = Label(text: "", fontSize: .headline, backgroundMode: .light(color: .primary), isFixedWitdh: false, leftItem: .none, rightItem: .none)
        
    public required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    override init(frame: CGRect) {
         super.init(frame: frame)
     }
    
    override var isSelected: Bool{
         didSet{
             if self.isSelected{
                createSelection()
             }
             else{
                removeSelection()
             }
         }
     }
    
    private func createLabel(title:String){
        titleLabel.setText(text: title)
        titleLabel.backgroundColor = menuProperties.cellBackgroundColor
        titleLabel.setTextColor(color: menuProperties.deselectedTextColor)
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    private func createSelection(){
        let bottomLayer = CAGradientLayer()
        bottomLayer.frame = CGRect(x: 16, y: titleLabel.frame.height + 2, width: titleLabel.frame.width - 32, height: 2)
        bottomLayer.colors = [UIColor.getPrimaryDark.cgColor, UIColor.getPrimary.cgColor]
        bottomLayer.startPoint = CGPoint(x: 0, y: 0)
        bottomLayer.endPoint = CGPoint(x: 1, y: 0)
        bottomLayer.name = "underline"
        if (titleLabel.frame.height != 0){
            titleLabel.layer.addSublayer(bottomLayer)
        }
        titleLabel.setTextColor(color: menuProperties.selectedTextColor)
    }
    
    private func removeSelection(){
        titleLabel.setTextColor(color: menuProperties.deselectedTextColor)
        for botLayer in titleLabel.layer.sublayers! {
            if botLayer.name == "underline" {
                botLayer.removeFromSuperlayer()
            }
        }
    }
    
    public func create(indexPath: IndexPath, isSelected:Bool, menuProperties:HorizontalMenuAttributes){
        self.menuProperties = menuProperties
        createLabel(title:menuProperties.menuTitles[indexPath.row])
        if isSelected{createSelection()}
        else {removeSelection()}
    }
    
}


