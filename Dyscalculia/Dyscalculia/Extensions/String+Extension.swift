//
//  String+Extension.swift
//  Dyscalculia
//
//  Created by Nick Arner on 9/11/20.
//  Copyright © 2020 nfa. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
