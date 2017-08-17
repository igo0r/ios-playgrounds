//
//  WaterControllerExtension.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 30/07/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

extension WaterViewController: NavigationBarActionProtocol {
    func saveBarButtonPressed(_ sender: UIBarButtonItem!) {
        guard let waterVC = storyboard?.instantiateViewController(withIdentifier: TimeEventViewController.storyboardID) else {
            print("View controller WaterViewController.storyboardID not found")
            return
        }
        if let vc = waterVC as? TimeEventViewController {
            if let form = waterForm as? WeekDayWaterForm {
                vc.configureTimeEventView(withWaterForm: form)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func cancelBarButtonPressed(_ sender: UIBarButtonItem!) {
        if let vc = getPreviousControllerFromNav() as? WeekDayController {
            if let waterForm = waterForm as? WeekDayWaterForm {
                vc.waterForm = waterForm
                guard (navigationController?.popViewController(animated:true)) != nil
                    else {
                        dismiss(animated: true, completion: nil)
                        return
                }
            }
        }
    }
    
    func setupeWeekDayBarButtons() {
        addBarLeftRightActionsWith(leftBtnTitle: "Back", rightBtnTitle: "Next")
    }
}
