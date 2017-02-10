//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

print(str)
var hello=43
let pops: Float = 44

print(pops)

let result = str + " and \(hello) \(pops)"
print(result)
var arrayNew = ["wrew", "fdff", "ee"]
var dicNew = ["1" : "fd", "34": "er"]

var couldBeNil: String? = "Igor"
couldBeNil = nil
var greeetings = "Hello"
if let name = couldBeNil {
    greeetings += " \(name)"
} else {
    greeetings = "nil!"
}

print(greeetings)

let vegatable = "apple"
let action: String?

switch vegatable {
case "banana", "cherry":
    action = "You can eat it"
case let x where x.contains("apple"):
    action = "Write it!"
default:
    action = "Dont touch it!"
}

print(action!)
var iterator : String = ""
for i in 0..<5 {
    iterator += String(i)
}
print(iterator)

func minMaxAvg(values: [Int], avg: (Int, Int) -> Int) ->  (min: Int, max: Int, avg: Int)
{
    var min: Int = values[0]
    var max: Int = values[0]
    var sum: Int = 0
    
    for value in values {
        func minfunc() {
            if(value < min){
                min = value
            }
        }
        minfunc()
        if(value > max){
            max = value
        }
        sum += value
    }
    
    return (min, max, avg(sum, values.count))
}

func avg(sum: Int, count: Int) -> Int{
    return (sum / count)
}

let arr = [100,2,5,3,1,3]
let mma = minMaxAvg(values: arr, avg: avg)
print(mma.avg)

let mapped = arr.map({number in 3 * number})
print(mapped)

class TestClass{
    var myVar = 0
    
    init(myVar: Int){
        self.myVar = myVar
    }
    
    func simplePlus(value: Int) -> Int {
        self.myVar += 1
        return value + 2 + self.myVar
    }
}

var testClass = TestClass(myVar: 5)
print(testClass.simplePlus(value: 4))

