//
//  MainVC.swift
//  MediTaco
//
//  Created by Igor Lantushenko on 06/03/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class MainVC: UIViewController, DataServiceProtocol {

    @IBOutlet weak var headerView: CustomView!
    @IBOutlet weak var tacoCollectionView: UICollectionView!
    
    let ds: DataService = DataService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ds.delegate = self
        tacoCollectionView.delegate = self
        tacoCollectionView.dataSource = self

        ds.loadDeliciousTacoData()
        ds.tacoArray.shuffle()
        
        headerView.addDropShadow()
        /*
        let nib = UINib(nibName: "TacoCell", bundle: nil)
        tacoCollectionView.register(nib, forCellWithReuseIdentifier: "TacoCell")*/
        tacoCollectionView.register(TacoCell.self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    internal func deliciousTacoDataLoaded() {
        tacoCollectionView.reloadData()
    }
    
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ds.tacoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /*if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TacoCell", for: indexPath) as? TacoCell {
            cell.configure(taco: ds.tacoArray[indexPath.row])
            //cell.frame.size = CGSize(width: 166, height: 161)
            return cell
        }*/
        let cell = collectionView.dequeReusableCell(forIndexPath: indexPath as NSIndexPath) as TacoCell
        cell.configure(taco: ds.tacoArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TacoCell {
            cell.shake()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 145)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 150, height: 145)
    }
    
}
