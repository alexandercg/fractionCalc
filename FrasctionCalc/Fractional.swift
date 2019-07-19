//
//  Fractional.swift
//  FrasctionCalc
//
//  Created by Alexander Camacho on 7/18/19.
//  Copyright © 2019 Alexander Camacho. All rights reserved.
//

import Foundation

public typealias Fraction = Fractional<Int>

public struct Fractional<Number: BinaryInteger> {
    /// The numerator of the fraction.
    public let numerator: Number
    
    /// The (always non-negative) denominator of the fraction.
    public let denominator: Number
    
    init(numerator: Number, denominator: Number) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    /// Create an instance initialized to `value`.
    init(_ value: Number) {
        self.init(numerator: value, denominator: 1)
    }
    
    /// Create an instance initialized to `string` with the next format `3_1/2`.
    init(string: String) {
        var isNegative =  false
        
        defer {
            if isNegative {
                self = Fraction(numerator: Int(self.numerator), denominator: -Int(self.denominator)) as! Fractional<Number>
            }
        }
        
        var value = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !value.isEmpty else {
            self.init(numerator: 0, denominator: 0)
            return
        }
        
        if value.contains("-") {
            isNegative = true
            value = value.replacingOccurrences(of: "-", with: "")
        }
        
        let values = value.components(separatedBy: "_")
        var fractions: [Fraction] = []
        values.forEach {
            let val = $0.components(separatedBy: "/")
            fractions.append(Fraction(numerator: Int(val[safe: 0] ?? "0") ?? 0,
                                      denominator: Int(val[safe: 1] ?? "1") ?? 1))
        }
        self = fractions.reduce(Fraction(0), +) as! Fractional<Number>
    }
}

extension Fractional: CustomStringConvertible {
    public var description: String {
        let denominatorInt = Int(denominator)
        let numeratorInt = Int(numerator)
        
        
        switch denominatorInt {
        case 1: return "\(numeratorInt)"
        default:
            if denominatorInt == 0 { return "Cannot make division by zero" }
            
            if numeratorInt > abs(denominatorInt) {
                let intValue = numeratorInt/denominatorInt
                let top = numeratorInt - (intValue*denominatorInt)
                let (newNumerator, newdenominator) = simplify(top: Int(top), bottom: denominatorInt)
                return "\(intValue)_\(abs(newNumerator))/\(abs(newdenominator))"
            }
            return "\(denominatorInt < 0 ? "-" : "")\(abs(numeratorInt))/\(abs(denominatorInt))"
        }
    }
}
