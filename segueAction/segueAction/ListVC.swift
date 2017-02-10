//
//  ListVC.swift
//  segueAction
//
//  Created by Igor Lantushenko on 29/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
    }

    @IBAction func backBtnAction(_ sender: Any) {
            dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextScreenBtnAction(_ sender: Any) {
        performSegue(withIdentifier: "DetailAction", sender: "Cool super soong")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailAction" {
            if segue.destination as? DetailVC != nil && (sender as? String) != nil {
                (segue.destination as! DetailVC).song = sender as! String
            }
        }
    }

}
