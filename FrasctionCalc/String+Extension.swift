//
//  String+Extension.swift
//  FrasctionCalc
//
//  Created by Alexander Camacho on 7/18/19.
//  Copyright © 2019 Alexander Camacho. All rights reserved.
//

import Foundation

extension String {
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
