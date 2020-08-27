//
//  StepIndicatorViewConstant.swift
//  PaycellUIKit
//
//  Created by OZNUR AKGUN on 1.04.2020.
//  Copyright © 2020 BARAN BATUHAN KARAOGUZ. All rights reserved.
//

import UIKit

protocol StepIndicatorViewConstant: ViewConstraintsProtocol {}

extension StepIndicatorViewConstant {
    var topConstant: CGFloat {
        0
    }
    
    var bottomConstant: CGFloat {
        0
    }
    
    var leadingConstant: CGFloat {
        0
    }
    
    var trailingConstant: CGFloat {
        0
    }

    var bulletStackViewMargins: (top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
        (top: 16, leading: 50, bottom: 0, trailing: 50)
    }
    
    var bulletStackViewHeight: CGFloat {
        48
    }
    
    var lineView: (leading: CGFloat, trailing: CGFloat, height: CGFloat) {
        (leading: 50, trailing: -50, height: 1)
    }
    
    var doneBullet: (width: CGFloat, height: CGFloat) {
        (width: 16, height: 16)
    }
    
    var todoBullet: (width: CGFloat, height: CGFloat) {
        (width: 16, height: 16)
    }
    
    var inProgressBullet: (width: CGFloat, height: CGFloat) {
        (width: 32, height: 32)
    }
    
    var inProgressLabel: (width: CGFloat, height: CGFloat) {
          (width: 32, height: 32)
      }
}
