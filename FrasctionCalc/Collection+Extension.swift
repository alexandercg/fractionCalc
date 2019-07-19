//
//  Collection+Extension.swift
//  FrasctionCalc
//
//  Created by Alexander Camacho on 7/18/19.
//  Copyright © 2019 Alexander Camacho. All rights reserved.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
