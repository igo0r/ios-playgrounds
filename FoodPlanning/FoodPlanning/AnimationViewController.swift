//
//  AnimationViewController.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 30/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit
import Foundation

class AnimationViewController: UIViewController {

    @IBOutlet weak var animatedView: MealMeLoaderView!
    
    weak var timer: Timer?

    var angle: Double = 0
    var counter = 0
    var isSeguePerformed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sleep(5)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.00001, target: self, selector: #selector(AnimationViewController.runAnimation), userInfo: nil, repeats: true)
        }
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.runAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    func runAnimation() {
        if angle < -335  && !isSeguePerformed {
            performSegue(withIdentifier: "mainLine", sender: nil)
            isSeguePerformed = true
        }
        
        if angle < -359 {
            timer?.invalidate()
            return
        }
        
        counter = counter + 1
        if counter < 9 {
            angle = angle - 0.05
        } else {
            angle = angle - 15
        }
        
        animatedView.angle = angle
        animatedView.setNeedsDisplay()
    }

}
