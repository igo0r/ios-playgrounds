//
//  ViewController.swift
//  scrollIT
//
//  Created by Igor Lantushenko on 28/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var images = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let scrollViewFrame = scrollView.frame
        var contentWidth = CGFloat(0.0)
        for i in 0..<3 {
            let imageView = UIImageView(image: UIImage(named: "icon\(i)"))
            let newX = scrollViewFrame.width/2 + (scrollViewFrame.width * CGFloat(i))
            contentWidth += newX
            imageView.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height/2) - 75 , width: 150, height: 150)
            
            images.append(imageView)
            scrollView.addSubview(imageView)
        }
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: scrollViewFrame.width * 3, height: scrollView.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

