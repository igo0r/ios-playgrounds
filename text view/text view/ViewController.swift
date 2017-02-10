//
//  ViewController.swift
//  text view
//
//  Created by Igor Lantushenko on 15/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ideasTextView: UITextView!
    @IBOutlet weak var sendButtonView: UIButton!
    
    @IBAction func sendAction(sender: AnyObject) {
        ideasTextView.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ideasTextView.delegate = self
        ideasTextView.text = "Write down your ideas"
        ideasTextView.textColor = UIColor.lightGrayColor()
        sendButtonView.hidden = true
        
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        if ideasTextView.text == "Write down your ideas" && ideasTextView.textColor == UIColor.lightGrayColor() {
           ideasTextView.text = ""
           ideasTextView.textColor = UIColor.blackColor()
        }
        sendButtonView.hidden = false
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if ideasTextView.text == "" {
            ideasTextView.text = "Write down your ideas"
            ideasTextView.textColor = UIColor.lightGrayColor()
        } else {
            ideasTextView.text = ideasTextView.text.stringByReplacingOccurrencesOfString("luck", withString: "****")
        }
        sendButtonView.hidden = true
    }
}

