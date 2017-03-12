//: Playground - noun: a place where people can play

import UIKit

let values: [Int] = [1,3,6,7]
let squares = values.map {$0 % 2 == 0 ? $0 - 1 : $0 + 1 }
print(squares)
