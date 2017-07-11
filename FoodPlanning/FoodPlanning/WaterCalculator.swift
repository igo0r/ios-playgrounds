//
//  WaterCalculator.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 29/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

enum MassMetric {
    case ounce
    case grams
    case kilogram
    case pound
}

enum Activity: Int {
    case Sedentary = 32
    case Light = 36
    case Moderately = 39
    case Hard = 43
    case ExtremelyHard = 49
}


//Note: This is only an estimate. The actual requirement may vary depending on many factors like fluid content in food, pregnancy, breast feeding, exercise, high altitude and medical abnormalities.
class WaterCalculator {
    
    let weightLbls = ["kg", "lbs"]
    let waterLbls = ["mls", "oz"]
    
    var waterMetric: MassMetric {
        return isCurrentSystemMetric ? .grams : .ounce
    }
    
    var weightMetric: MassMetric {
        return isCurrentSystemMetric ? .kilogram : .pound
    }
    
    var activity: Activity {
        get {
            return Activity(rawValue: UserDefaultsUtils.getDayActivity()) ?? .Sedentary
        }
        set {
            UserDefaultsUtils.setDayActivity(value: newValue.rawValue)
        }
    }

    /*
     internal variable only in KG
     */
    private var _weight: Double {
        get {
            return UserDefaultsUtils.getWeight()
        }
        set {
            UserDefaultsUtils.setWeight(value: newValue)
        }
    }
    
    /*
     returns kg or lbs
     */
    var weight: Double {
        get {
            var valueMeasure = getValueMeasure(value: _weight, metric: .kilogram)
            valueMeasure.convert(to: getUnitmass(metricToSwitch: weightMetric))
            return valueMeasure.value
        }
        set {
            var valueMeasure = getValueMeasure(value: newValue, metric: weightMetric)
            valueMeasure.convert(to: .kilograms)
            _weight = valueMeasure.value
        }
    }
    
    var isCurrentSystemMetric: Bool {
        get {
            return UserDefaultsUtils.isCurrentSystemMetric()
        } set {
            UserDefaultsUtils.setCurrentSystem(isMetric: newValue)
        }
    }
    
    /*
     internal variable only in GRAMS
     */
    private var _waterQuantity: Double {
        get {
            return UserDefaultsUtils.getWaterQuantity()
        }
        set {
            UserDefaultsUtils.setWaterQuantity(value: newValue)
        }
    }
    
    /*
     returns grams or oz
     */
    var waterQuantity: Double {
        get {
            var valueMeasure = getValueMeasure(value: _waterQuantity, metric: .grams)
            valueMeasure.convert(to: getUnitmass(metricToSwitch: waterMetric))
            return valueMeasure.value
        }
        set {
            var valueMeasure = getValueMeasure(value: newValue, metric: waterMetric)
            valueMeasure.convert(to: .grams)
            _waterQuantity = valueMeasure.value
        }
    }
    
    init() {
        activity = Activity(rawValue: UserDefaultsUtils.getDayActivity()) ?? .Sedentary
        _weight = UserDefaultsUtils.getWeight()
    }
    
    func divideWaterQuantityFor(times: Int) -> Int{
        return Int(waterQuantity) / times
    }
    
    /*
     current KG weight and activity
     */
    func calculateWaterQuantity() {
        _waterQuantity = _weight * Double(activity.rawValue)
    }
    
    /*
     returns value according to current isMetricSytem setting
     */
    func getValueMeasure(value: Double, metric: MassMetric) -> Measurement<UnitMass> {
        return Measurement(value: value, unit: getUnitmass(metricToSwitch: metric))
    }
    
    func getUnitmass(metricToSwitch: MassMetric) -> UnitMass {
        switch metricToSwitch {
        case .kilogram:
            return .kilograms
        case .pound:
            return .pounds
        case .grams:
            return .grams
        case .ounce:
            return .ounces
        }
    }
    
    func getWaterLblTxt() -> String {
        return isCurrentSystemMetric ? waterLbls[0] : waterLbls[1]
    }
    
    func getWeightLblTxt() -> String {
        return isCurrentSystemMetric ? weightLbls[0] : weightLbls[1]
    }
}
