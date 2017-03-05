//: Playground - noun: a place where people can play

import UIKit

protocol Vehicle: CustomStringConvertible {
    var isRunning: Bool { get set }
    mutating func start()
    mutating func turnOff()
}

struct SportsCar: Vehicle {
    

    mutating func turnOff() {
        if isRunning {
            isRunning = false
            print("Stop it!!")
        } else {
            print("already stopped")
        }
    }

    mutating func start() {
        if isRunning {
            print("Already running!!")
        } else {
            isRunning = true
            print("Lets start it")
        }
    }

    var isRunning: Bool = false
    var description: String {
        if isRunning {
            return "SportsCar currently running"
        } else {
            return "Not running!!11"
        }
    }
}

class SemiTruck: Vehicle {
    var isRunning: Bool = false
    var description: String {
        if isRunning {
            return "Semitruck currently running"
        } else {
            return "Semitruck shutdown"
        }
    }
    
    func turnOff() {
        if isRunning {
            isRunning = false
            print("Lets stop it")
        } else {
            print("Already stopped")
        }
    }
    
    func start() {
        if isRunning {
            print("Already started")
        } else {
            isRunning = true
            print("Lets start it")
        }
    }
    
    func blowAirHorn() {
        print("TOOOOOTOOOO!!!")
    }
}

var car1 = SportsCar()
var truck1 = SemiTruck()

car1.start()
truck1.start()

car1.turnOff()
truck1.turnOff()

var vehicles: [Vehicle] = [car1, truck1]
for vehicle in vehicles {
    print(vehicle)
    if let semi = vehicle as? SemiTruck {
        semi.blowAirHorn()
    }
}
