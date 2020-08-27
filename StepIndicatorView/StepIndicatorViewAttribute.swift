//
//  StepIndicatorViewAttribute.swift
//  PaycellUIKit
//
//  Created by OZNUR AKGUN on 1.04.2020.
//  Copyright © 2020 BARAN BATUHAN KARAOGUZ. All rights reserved.
//

import UIKit
import PaycellCore

enum StepIndicatorViewState {
    case todo
    case inProgress
    case done
}

public struct StepIndicatorViewModel {
    public let title: String
    public var desc: String?
    
    public init(title: String, desc: String? = nil) {
        self.title = title
        self.desc = desc
    }
}

struct StepIndicatorViewAttribute: StepIndicatorViewConstant {
    var inProgressBulletRadius: CGFloat = 16
    var todoBulletRadius: CGFloat = 8
    
    var inProgressBulletColor: UIColor = .getBlack
    var todoBulletColor: UIColor = .getGray
    var doneBulletColor: UIColor = .getWhite

    var inProgressLabelColor: TextColorType = .black
    var doneAndTodoLabelColor: TextColorType = .gray
}
