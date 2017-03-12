//: Playground - noun: a place where people can play

import UIKit

func fact(forNumber: Int) -> Int {
    if forNumber == 1 {
        return 1
    }
    return forNumber * fact(forNumber: forNumber - 1)
}

print(fact(forNumber: 12 ))