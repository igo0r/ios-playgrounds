//
//  ViewController.swift
//  testTimer
//
//  Created by Igor Lantushenko on 25/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var pauseView: UIButton!
    @IBOutlet weak var stopView: UIButton!
    @IBOutlet weak var startView: UIButton!
    
    var counter = 0.0
    var timer = Timer()
    
    
    @IBAction func startAction(_ sender: Any) {
        startView.isEnabled = false
        pauseView.isEnabled = true
        stopView.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopAction(_ sender: Any) {
        startView.isEnabled = true
        pauseView.isEnabled = false
        stopView.isEnabled = false
        
        timer.invalidate()
        counter = 0.0
        textView.text = String(counter)
    }
    
    @IBAction func pauseAction(_ sender: Any) {
        startView.isEnabled = true
        pauseView.isEnabled = false
        stopView.isEnabled = true
        
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView.text = String(counter)
        pauseView.isEnabled = false
        stopView.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateTimer() {
        counter = counter + 0.1
        textView.text = String(format: "%.1f", counter)
    }
}

