//
//  BidriectionallCollectionExtension.swift
//  Dyscalculia
//
//  Created by Nick Arner on 9/27/20.
//  Copyright © 2020 nfa. All rights reserved.
//

import Foundation

extension BidirectionalCollection where Element: Equatable {
    func before(_ element: Element, loop: Bool = false) -> Element? {
        if element == first && loop { return last }
        guard let index = dropFirst().firstIndex(of: element) else {
            return nil
        }
        return self[self.index(before: index)]
    }
}
