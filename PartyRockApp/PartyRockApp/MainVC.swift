//
//  ViewController.swift
//  PartyRockApp
//
//  Created by Igor Lantushenko on 07/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var partyRockData = [PartyRock]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let partyRock = PartyRock(imageUrl: "https://tproger2.azureedge.net/wp-content/uploads/2015/03/1.jpg", videoUrl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/dsA-Ib9H-YQ\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "VLOG GRINYA #13 - автосервис DPRO, готовимся ко второму этапу WinterDrift")
        let partyRock1 = PartyRock(imageUrl: "https://tproger2.azureedge.net/wp-content/uploads/2015/03/1.jpg", videoUrl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/dsA-Ib9H-YQ\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "VLOG GRINYA #13 - автосервис DPRO, готовимся ко второму этапу WinterDrift")
        let partyRock2 = PartyRock(imageUrl: "https://tproger2.azureedge.net/wp-content/uploads/2015/03/1.jpg", videoUrl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/dsA-Ib9H-YQ\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "VLOG GRINYA #13 - автосервис DPRO, готовимся ко второму этапу WinterDrift")
        let partyRock3 = PartyRock(imageUrl: "https://tproger2.azureedge.net/wp-content/uploads/2015/03/1.jpg", videoUrl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/dsA-Ib9H-YQ\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "VLOG GRINYA #13 - автосервис DPRO, готовимся ко второму этапу WinterDrift")
        let partyRock4 = PartyRock(imageUrl: "https://tproger2.azureedge.net/wp-content/uploads/2015/03/1.jpg", videoUrl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/dsA-Ib9H-YQ\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "VLOG GRINYA #13 - автосервис DPRO, готовимся ко второму этапу WinterDrift")
        let partyRock5 = PartyRock(imageUrl: "https://tproger2.azureedge.net/wp-content/uploads/2015/03/1.jpg", videoUrl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/dsA-Ib9H-YQ\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "VLOG GRINYA #13 - автосервис DPRO, готовимся ко второму этапу WinterDrift")
        let partyRock6 = PartyRock(imageUrl: "https://tproger2.azureedge.net/wp-content/uploads/2015/03/1.jpg", videoUrl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/dsA-Ib9H-YQ\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "VLOG GRINYA #13 - автосервис DPRO, готовимся ко второму этапу WinterDrift")
        
        partyRockData.append(partyRock)
        partyRockData.append(partyRock1)
        partyRockData.append(partyRock2)
        partyRockData.append(partyRock3)
        partyRockData.append(partyRock4)
        partyRockData.append(partyRock5)
        partyRockData.append(partyRock6)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyRockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "videoView", for: indexPath) as? PartyVideoVC {
            let partyRock = partyRockData[indexPath.row]
            cell.updateView(partyRock: partyRock)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let party = partyRockData[indexPath.row]
        self.performSegue(withIdentifier: "videoDetail", sender: party)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ((segue.destination as? VideoVC) != nil) {
            if (sender as? PartyRock) != nil {
                let destination = segue.destination as! VideoVC
                    destination.partyRock  = sender as! PartyRock
            }
        }
        
    }

    
}

