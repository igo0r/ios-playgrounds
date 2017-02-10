//
//  UIDetailViewController.swift
//  tableCell
//
//  Created by Igor Lantushenko on 28/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class UIDetailViewController: UIViewController {

    @IBOutlet weak var viewView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var data = Article()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Article"
        imageView.image = data.image
        labelView.text = data.title
        textView.text = data.text
        
        var viewFrame = viewView.frame
        viewFrame.size.height += textView.contentSize.height - textView.frame.size.height
        
        viewView.frame = viewFrame
        scrollView.contentSize = viewFrame.size
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
