//
//  NumberBaseball - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

var randomAnswer: [Int]
var count: Int = 9

struct NumberBaseball{
    func randomNumber() -> [Int] {
        var result = [Int]()
        while result.count < 3 {
            let number = Int.random(in: 1...9)
            if result.contains(number) { continue }
            result.append(number)
        }
        return result
    }
}
