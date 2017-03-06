//: Playground - noun: a place where people can play

import UIKit

func intAdder(number: Int) -> Int {
    return number + 1
}

func doubleAdder(number: Double) -> Double {
    return number + 1
}

func genericAdder<T: Strideable>(number: T) -> T {
    return number + 1
}

intAdder(number: 14)
doubleAdder(number: 14.0)
genericAdder(number: 14.0)
genericAdder(number: 17)

func intMultiplier(lhs: Int, rhs: Int) -> Int {
    return lhs * rhs
}
func doubleMultiplier(lhs: Double, rhs: Double) -> Double {
    return lhs * rhs
}

intMultiplier(lhs: 3, rhs: 7)
doubleMultiplier(lhs: 3.4, rhs: 7.2)

protocol Numeric {
    static func *(lhs: Self, rhs: Self) -> Self
}

extension Double: Numeric {}
extension Float: Numeric {}

func genericMultiplier<T: Numeric>(lhs: T, rhs: T) -> T {
    return lhs * rhs
}

genericMultiplier(lhs: 3.4, rhs: 7.2)


protocol Multiplier {
    func *(element: Element)
}

struct ArrayMultiplier<Element>: Multiplier {
    var elements = [Element]()
    mutating func pushWithDoubling(_ element: Element) {
        elements.append(element)
    }
}


var arr = ArrayMultiplier<String>()
arr.pushWithDoubling("we")









