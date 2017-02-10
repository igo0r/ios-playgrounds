//
//  DetailVC.swift
//  segueAction
//
//  Created by Igor Lantushenko on 29/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var songLabel: UILabel!
    
    private var _song: String = ""
    
    var song: String  {
        get {
            return _song
        } set {
            _song = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songLabel.text = song
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
