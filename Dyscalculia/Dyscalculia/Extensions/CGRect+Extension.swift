//
//  CGRect+Extension.swift
//  Dyscalculia
//
//  Created by Nick Arner on 9/11/20.
//  Copyright © 2020 nfa. All rights reserved.
//

import UIKit

extension CGRect {
    var randomPoint: CGPoint {
        var point = CGPoint()
        point.x = CGFloat.random(between: origin.x, and: origin.x + width)
        point.y = CGFloat.random(between: origin.y, and: origin.y + height)
        return point
    }
}
