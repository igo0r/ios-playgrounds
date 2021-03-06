//
//  Constants.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 11/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//
import UIKit

//App id for rates
let appID = "1245564580"
let appEmail = "help@mealmeintime.com"

let waterBeforeMeal = "waterBeforeMeal"

//Water calculator
let currentSystemIsMetric = "currentSystemIsMetric"
let waterQuantity = "waterQuantity"
let dayActivity = "dayActivity"
let weight = "weight"

let currentDayKey = "currentDayKey"
let defaultUserDayKey = "defaultUserDayKey"
let notificationIdentifierPrefix = "MealMeNotify"
let mealsCountArr = Array(3...10)
let secondsFrom3Hours: Double = (60 * 60 * 3)
let secondsFrom13Hours: Double = (60 * 60 * 13)

//Rate section
let successPathes = "successPathes"
let agreeToReview = "agreeToReview"
let dontAskToReview = "dontAskToReview"
let disagreeToReview = "disagreeToReview"

//ProgressView
//let progressViewMaxValue: Double = 147
let progressViewMaxValue: Double = 150

//Water settings
let waterTime = "waterTime"
let waterTimeRange = Array(5...50)

//Fonts
let fontRegular14 = UIFont(name: "AvenirNext-Regular", size: 14)!
let fontMedium17 = UIFont(name: "AvenirNext-Medium", size: 17)!
let fontMedium15 = UIFont(name: "AvenirNext-Medium", size: 15)!
let fontMedium20 = UIFont(name: "AvenirNext-Medium", size: 20)!
let fontDemiBold15 = UIFont(name: "AvenirNext-DemiBold", size: 15)!
let fontDemiBold17 = UIFont(name: "AvenirNext-DemiBold", size: 17)!
let fontDemiBold18 = UIFont(name: "AvenirNext-DemiBold", size: 18)!

//Colors
let opacity0 = UIColor(hex: "000000", alpha: 0)
let black = UIColor(hex: "000000", alpha: 0.7)
let blackHalf = UIColor(hex: "000000", alpha: 0.5)
let white = UIColor(hex:"E4E0E0")
let green = UIColor(hex: "A7E6A0")
let whiteColor = UIColor(hex: "EEEEEE")
let grayColor = UIColor(hex: "9B9B9B")
let redColor = UIColor(hex: "F0554A")

//Notification identifiers
let requestPermissionsCounter = "requestPermissionsCounter"
let savePlanCounter = "savePlanCounter"
let eventNotificationKey = "eventNotificationKey"
let specialNotificationReminder = "specialNotificationReminder"
let okNotificationCategory = "OkNotificationCategory"
