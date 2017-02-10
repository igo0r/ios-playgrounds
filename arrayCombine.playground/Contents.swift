//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var firstArr = ["a", "b", "c"]
var secondArr = ["bo", "ro", "me"]

func arrayCombine (firstArr: [String], secondArr: [String]) -> [String]{
    var resultArr = [String]()
    
    for key in 0..<firstArr.count{
        resultArr.append(firstArr[key])
        resultArr.append(secondArr[key])
    }
    
    return resultArr
}

print(arrayCombine(firstArr: firstArr, secondArr: secondArr))
