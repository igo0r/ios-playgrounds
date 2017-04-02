//
//  ViewController.swift
//  IOS10DrawShapesTutorial
//
//  Created by Igor Lantushenko on 02/04/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPressed(_ sender: AnyObject) {
        let myView = ShapeView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 250), shape: sender.tag)
        
        myView.backgroundColor = UIColor.purple
        view.addSubview(myView)
    }
}

