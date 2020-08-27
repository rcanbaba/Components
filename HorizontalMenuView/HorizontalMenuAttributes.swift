//
//  HorizontalMenuAttributes.swift
//  PaycellUIKit
//
//  Created by RECEP CAN BABAOGLU on 24.07.2020.
//  Copyright © 2020 BARAN BATUHAN KARAOGUZ. All rights reserved.
//

import Foundation
import UIKit
import PaycellCore

public enum MenuIndex: Int{
    case first = 999
    case second
    case third
    
}

public enum MenuType{
    case normal
    case type2
}

public struct HorizontalMenuAttributes{
    var menuIndex:MenuIndex
    var selectedIndex: Int = 0
    var deselectedTextColor: TextColorType
    var selectedTextColor: TextColorType
    var underlineBarColor: UIColor
    var collectionViewBackgroundColor: UIColor
    var cellBackgroundColor: UIColor
  //  var textFontSize: CGFloat
    var menuTitles:[String]
    
    public init(menuIndex: MenuIndex, selectedIndex: Int?, menuTitles:[String] ) {
        self.menuIndex = menuIndex
        self.selectedIndex = selectedIndex!
        self.deselectedTextColor = .gray
        self.selectedTextColor = .black
        self.underlineBarColor = .getGray9
        self.collectionViewBackgroundColor = .getClear
        self.cellBackgroundColor = .getClear
      //  self.textFontSize = 16
        self.menuTitles = menuTitles
    }

}


