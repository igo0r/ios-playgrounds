//
//  VideoVC.swift
//  PartyRockApp
//
//  Created by Igor Lantushenko on 07/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class VideoVC: UIViewController {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    private var _partyRock: PartyRock!
    
    var partyRock : PartyRock{
        get{
            return _partyRock
        } set {
            _partyRock = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleView.text = partyRock.videoTitle
        webView.loadHTMLString(partyRock.videoUrl, baseURL: nil)
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
