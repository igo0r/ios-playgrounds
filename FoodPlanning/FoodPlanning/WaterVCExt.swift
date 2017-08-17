//
//  WaterVCExt.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 01/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

extension WaterViewController {
    
    func setupStandAloneBarButtons() {
        /*let rightBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveBarButtonStandAlonePressed(_:)))
        
        rightBarButton.tintColor = green
        rightBarButton.isEnabled = false
        self.navigationItem.rightBarButtonItem = rightBarButton*/
    }
    
    func saveBarButtonStandAlonePressed(_ sender: UIBarButtonItem) {
        let row = waterTimerPicker.selectedRow(inComponent: 0)
        
        waterForm.waterTime = waterTimeRange[row]
        waterForm.isWaterOn = waterSwitcher.isOn
        
        
        BackgroundTaskTracker.requestToUpdateNotifications()
    }
}
