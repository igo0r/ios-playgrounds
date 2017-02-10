//
//  ViewController.swift
//  button with background
//
//  Created by Igor Lantushenko on 18/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var actionButtonView: UIButton!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var backgroundView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonAction(_ sender: Any) {
        logoView.isHidden = false
        backgroundView.isHidden = false
        actionButtonView.isHidden = true
        
    }
}

