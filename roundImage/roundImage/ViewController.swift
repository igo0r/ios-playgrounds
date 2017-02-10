//
//  ViewController.swift
//  roundImage
//
//  Created by Igor Lantushenko on 09/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fullNameView: UILabel!
    @IBOutlet weak var renameFieldView: UITextField!
    let person = Person(first: "Igor", last: "Lantushenko")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameView.text = person.fullName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rnmBtn(_ sender: Any) {
        if let txt = renameFieldView.text {
            person.firstName = txt
            fullNameView.text = person.fullName
            renameFieldView.text = ""
        }
    }

}

