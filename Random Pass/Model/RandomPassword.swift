//
//  RandomPassword.swift
//  Random Pass
//
//  Created by Daniel Arribas on 10/23/23.
//

import Foundation

struct RandomPassword {
    
    let symbols = "~`!@#$%^&*()_-+={[}]|\\:;\"'<,>.?/"
    let lowerCase = "abcdefghijklmnopqrstuvwxyz"
    let upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let numbers = "01234567890"
    var subset = ""
    var pwd = ""
    
    mutating func generatePass(_ useNumbers: Bool, _ useLower: Bool, _ useUpper: Bool, _ useSymbols: Bool, _ length: Int) -> String {
        pwd = ""
        subset = ""
        // Create subset of characters used in password
        if useNumbers {
            subset.append(numbers)
        }
        if useLower {
            subset.append(lowerCase)
        }
        if useUpper {
            subset.append(upperCase)
        }
        if useSymbols {
            subset.append(symbols)
        }
        
        // Create password using random items from the subset
        for _ in 0 ..< length {
            if let chr = subset.randomElement() {
                pwd.append(chr)
            }
        }
        
        print(pwd)
        return pwd
    }
}
