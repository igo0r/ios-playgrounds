//
//  ViewController.swift
//  ProgressBar
//
//  Created by Igor Lantushenko on 09/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sliderView: UISlider!
    @IBOutlet weak var progressBarView: ProgressBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func slideAction(_ sender: Any) {
        progressBarView.progress = CGFloat(sliderView.value)
    }

}

