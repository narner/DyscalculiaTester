//
//  CGFloat+Extension.swift
//  Dyscalculia
//
//  Created by Nick Arner on 9/11/20.
//  Copyright © 2020 nfa. All rights reserved.
//

import UIKit

extension CGFloat {
    static var random: CGFloat { return CGFloat(arc4random()) / CGFloat(UInt32.max) }

    static func random(between x: CGFloat, and y: CGFloat) -> CGFloat {
        let (start, end) = x < y ? (x, y) : (y, x)
        return start + CGFloat.random * (end - start)
    }
}
