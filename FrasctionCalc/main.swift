//
//  main.swift
//

import Foundation

func input() -> String {
    let keyboard = FileHandle.standardInput
    let inputData = keyboard.availableData
    let result = String(data: inputData, encoding: .utf8)?.replacingOccurrences(of: "\n", with: "")
    return result ?? ""
}

func validateInputFormat(string: String) -> Bool {
    let characterset = CharacterSet(charactersIn: " 0123456789_-+/*")
    return string.rangeOfCharacter(from: characterset.inverted) == nil
}

func main() {
    
    let inputText = input().condenseWhitespace()
    let elements =  inputText.components(separatedBy: " ")
    
    guard validateInputFormat(string: inputText),
        let lhs = elements[safe: 0],
        let op = elements[safe: 1],
        let rhs = elements[safe: 2] else {
        print("Invalid input format")
        return
    }

    print(calculate(num1: Fraction(string: lhs), op: op, num2: Fraction(string: rhs)))
    
}

print("Enter your operation (Format e.g. 2_3/8 + 9/8 )")
main()

