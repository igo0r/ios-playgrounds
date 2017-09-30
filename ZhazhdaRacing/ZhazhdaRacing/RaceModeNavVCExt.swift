//
//  RaceModeNavVCExt.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 01/09/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

extension RacerModeVC: VCNavButtons {
    
    func leftBarButtonPressed(_ sender: UIBarButtonItem!) {
        goToPreviousViewController()
    }
    
    func rightBarButtonPressed(_ sender: UIBarButtonItem!) {
        let tableViewController = TeamListTVC()
        tableViewController.modalPresentationStyle = UIModalPresentationStyle.popover
        tableViewController.selectionHandler = self.selectionHandler
        
        present(tableViewController, animated: true, completion: nil)
    }
    
    func selectionHandler(selectedItem: Team) {
        //self.selectedItem = selectedItem
        /* Do something with the selected item */
    }
    
}
