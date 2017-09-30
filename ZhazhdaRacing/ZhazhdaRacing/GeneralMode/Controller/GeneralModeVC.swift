//
//  GeneralModeVC.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 21/09/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class GeneralModeVC: UIViewController {

    @IBOutlet weak var gridTable: UICollectionView!
    static let storyboardID = "GeneralModeVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar(withTitle: "Race information")
        configureView()
        
        gridTable.dataSource = self
        gridTable.delegate = self
        gridTable.register(UINib(nibName: "GeneralModeCell", bundle: nil), forCellWithReuseIdentifier: GeneralModeCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GeneralModeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralModeCell.identifier, for: indexPath) as? GeneralModeCell {
            cell.configure(withText: "Ololo")
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
