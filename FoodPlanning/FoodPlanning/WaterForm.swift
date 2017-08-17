//
//  WaterForm.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 03/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

class WaterForm: DefaultWaterForm {
    
    init() {
        super.init(withWaterCondition: .WaterTemplateView)
        setNavBarTitle("Water template")
    }
}
