//
//  ViewController.swift
//  images
//
//  Created by Igor Lantushenko on 22/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var buttonView: UIButton!
    var imageSet = ["111", "222", "333"]
    var key = 0

    @IBAction func changeImageAction(_ sender: Any) {
        self.key += 1
        if self.key == imageSet.count{
            self.key = 0
        }
        self.topImageView.image = UIImage(named: self.imageSet[self.key])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image : UIImage = UIImage(named: "1")!
        let patternImage = UIColor(patternImage: image)
        self.view.backgroundColor = patternImage
        
        let imageButton : UIImage = UIImage(named: "button")!
        let stretchImage = imageButton.stretchableImage(withLeftCapWidth: 14, topCapHeight: 0)
        
        self.topImageView.image = UIImage(named: self.imageSet[0])
        self.buttonView.setBackgroundImage(stretchImage, for: UIControlState.normal)
        self.buttonView.setBackgroundImage(stretchImage, for: UIControlState.highlighted)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

