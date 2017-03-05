//: Playground - noun: a place where people can play

import UIKit

protocol Vehicle: CustomStringConvertible {
    var isRunning: Bool { get set }
    var make: String {get set}
    var model: String {get set}
    mutating func start()
    mutating func turnOff()
}

extension Vehicle {
    var makeModel: String {
        return "\(make) \(model)"
    }
    
    mutating func start() {
        if isRunning {
            print("Already running!!111")
        } else {
            isRunning = true
            print("\(self.description)")
        }
    }
    
    mutating func turnOff() {
        if isRunning {
            isRunning = false
            print("\(self.description) shutdown")
        } else {
            print("already stopped!!!11")
        }
    }
}

struct SportsCar: Vehicle {
    
    var make: String
    var model: String
    var isRunning: Bool = false
    var description: String {
        return self.makeModel
    }
}

class SemiTruck: Vehicle {
    var isRunning: Bool = false
    var make: String
    var model: String
    
    init(isRunning: Bool, make: String, model: String) {
        self.isRunning = isRunning
        self.make = make
        self.model = model
    }
    var description: String {
        return self.makeModel
    }
    

    func blowAirHorn() {
        print("TOOOOOTOOOO!!!")
    }
}

var car1 = SportsCar(make: "Porsche", model: "911", isRunning: false)
var truck1 = SemiTruck(isRunning: false, make: "Mercedes", model: "Lucia")

car1.start()
truck1.start()

car1.turnOff()
truck1.turnOff()

var vehicles: [Vehicle] = [car1, truck1]
for vehicle in vehicles {
    print(vehicle.makeModel)
    if let semi = vehicle as? SemiTruck {
        semi.blowAirHorn()
    }
}

extension Double {
    var dollarString: String {
        return String(format: "$%.02f", self)
    }
}

var test = 23.45 * 0.23
print (test.dollarString)