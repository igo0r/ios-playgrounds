//
//  ViewController.swift
//  imageChange
//
//  Created by Igor Lantushenko on 22/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var allView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
/*        let backgroundImage : UIImage = UIImage(contentsOfFile: "1.png")!
        self.allView.image = backgroundImage.imageFlippedForRightToLeftLayoutDirection()
  */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

