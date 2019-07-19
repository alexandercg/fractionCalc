//
//  Operators.swift
//  FrasctionCalc
//
//  Created by Alexander Camacho on 7/18/19.
//  Copyright © 2019 Alexander Camacho. All rights reserved.
//

import Foundation

/// Symplify the fraction values to the minimum common denominator
func simplify(top:Int, bottom:Int) -> (newTop:Int, newBottom:Int) {
    var x = top
    var y = bottom
    while (y != 0) {
        let buffer = y
        y = x % y
        x = buffer
    }
    let hcfVal = x
    let newTopVal = top/hcfVal
    let newBottomVal = bottom/hcfVal
    return(newTopVal, newBottomVal)
}

/// Add `lhs` and `rhs`, returning a reduced result.
func +<Number: BinaryInteger>(lhs: Fractional<Number>, rhs: Fractional<Number>) -> Fraction {
    let bottom = lhs.denominator * rhs.denominator
    let top = (lhs.numerator * rhs.denominator) + (rhs.numerator * lhs.denominator)
    
    let (numerator, denominator) = simplify(top: Int(top), bottom: Int(bottom))
    return Fractional(numerator: numerator, denominator: denominator)
}

/// Multiply `lhs` and `rhs`, returning a reduced result.
func *<Number: BinaryInteger>(lhs: Fractional<Number>, rhs: Fractional<Number>) -> Fraction {
    let swapped = (Fractional(numerator: lhs.numerator, denominator: rhs.denominator),
                   Fractional(numerator: rhs.numerator, denominator: lhs.denominator))
    return Fractional(numerator: swapped.0.numerator * swapped.1.numerator, denominator: swapped.0.denominator * swapped.1.denominator) as! Fraction
}

/// Subtract `lhs` and `rhs`, returning a reduced result.
func -<Number: BinaryInteger>(lhs: Fractional<Number>, rhs: Fractional<Number>) -> Fraction {
    let bottom = lhs.denominator * rhs.denominator
    let top = (lhs.numerator * rhs.denominator) - (rhs.numerator * lhs.denominator)
    let (numerator, denominator) = simplify(top: Int(top),
                                            bottom: Int(bottom))
    return Fractional(numerator: numerator, denominator: denominator)
}

// Divide `lhs` and `rhs`, returning a reduced result.
func /<Number: BinaryInteger>(lhs: Fractional<Number>, rhs: Fractional<Number>) -> Fraction {
    let top = lhs.numerator * rhs.denominator
    let bottom = rhs.numerator * lhs.denominator
    let (numerator, denominator) = simplify(top: Int(top), bottom: Int(bottom))
    return Fractional(numerator: numerator, denominator: denominator)
}

func calculate(num1: Fraction, op: String, num2: Fraction) -> Fraction {
    switch op {
    case "+":
        return num1 + num2
    case "-":
        return num1 - num2
    case "*":
        return num1 * num2
    case "/":
        return num1 / num2
    default:
        return Fraction(numerator: 0, denominator: 0)
    }
}
