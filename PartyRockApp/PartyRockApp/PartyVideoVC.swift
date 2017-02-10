//
//  PartyVideoVC.swift
//  PartyRockApp
//
//  Created by Igor Lantushenko on 08/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class PartyVideoVC: UITableViewCell {
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var imageRockView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView(partyRock: PartyRock) {
        titleView.text = partyRock.videoTitle
        let url = URL(string: partyRock.imageUrl)
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url!)
                DispatchQueue.global().sync {
                    self.imageRockView.image = UIImage(data: data)
                }
            } catch _ as NSError {
            }
            
        }
    }

}
