//
//  Int+Extension.swift
//  Dyscalculia
//
//  Created by Nick Arner on 9/11/20.
//  Copyright © 2020 nfa. All rights reserved.
//

import Foundation


extension Int {
   var asWord: String {
    let numberValue = NSNumber(value: self)
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    return formatter.string(from: numberValue)!
  }
}
