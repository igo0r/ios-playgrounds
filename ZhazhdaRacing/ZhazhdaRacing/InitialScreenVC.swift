//
//  ViewController.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 17/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit


enum ActionType: Int {
    case GeneralView = 0
    case RacerView
    case ScoreView
    
    func getIdentifier() -> String {
        switch self {
        case .RacerView:
            return RacerModeVC.storyboardID
        case .GeneralView:
            return RacerModeVC.storyboardID
        case .ScoreView:
            return RacerModeVC.storyboardID
        }
    }
}
class InitialScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    @IBAction func typeBtnPrsd(_ sender: UIButton) {
        let type = ActionType(rawValue: sender.tag) ?? ActionType.GeneralView
        guard let vc = storyboard?.instantiateViewController(withIdentifier: type.getIdentifier()) else {
            print("View controller with identifier \(type.getIdentifier()) not found")
            return
        }
        
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
        //nav.pushViewController(vc, animated: true)
    }
}

