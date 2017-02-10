//
//  ViewController.swift
//  text input
//
//  Created by Igor Lantushenko on 15/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var submitButtonView: UIButton!
    
    @IBOutlet weak var ideaTableView: UITableView!
    @IBOutlet weak var resultLabelView: UILabel!
    @IBOutlet weak var ideaFieldView: UITextField!
    
    @IBAction func submitButtonAction(sender: AnyObject) {
        if(ideaFieldView.text == ""){
            return
        }
        
        resultLabelView.text = "This is your first idea: \(ideaFieldView.text!)"
        ideaFieldView.text = ""
        ideaFieldView.resignFirstResponder()
        let nib = UINib.init(nibName: "Test", bundle: nil)
        ideaTableView.registerNib(nib, forCellReuseIdentifier: "Olo")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ideaFieldView.delegate = self
        submitButtonView.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        submitButtonView.hidden = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        submitButtonView.hidden = true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        submitButtonAction(self)
        
        return true
    }

}

