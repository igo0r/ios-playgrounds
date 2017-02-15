//
//  MainVC.swift
//  DreamList
//
//  Created by Igor Lantushenko on 11/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import CoreData
import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var controller: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
       // generateTestData()
        attemptFetch()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = controller.object(at: indexPath as IndexPath)
        performSegue(withIdentifier: "ItemDetailsVC", sender: cell)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailsVC" {
            if let destination = segue.destination as? ItemDetailVC {
                if let item = sender as? Item {
                    destination.item = item
                }
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    @IBAction func segmentSelected(_ sender: Any) {
        attemptFetch()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func attemptFetch(){
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        let toItemType = NSSortDescriptor(key: "toItemType.type", ascending: true)
        
        if segmentView.selectedSegmentIndex == 0 {
            fetchRequest.sortDescriptors = [dateSort]
        } else if segmentView.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [priceSort]
        } else if segmentView.selectedSegmentIndex == 2 {
            fetchRequest.sortDescriptors = [titleSort]
        } else if segmentView.selectedSegmentIndex == 3 {
            fetchRequest.sortDescriptors = [toItemType]
        }
        
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.controller = controller
        do{
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print(error)
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type){
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    func generateTestData(){
        let item = Item(context: context)
        item.title = "MacBook Pro"
        item.price = 1500
        item.details = "Thats gonna be awesome one, I need to buy it"
        
        let item1 = Item(context: context)
        item1.title = "MacBook Pro 15"
        item1.price = 1800
        item1.details = "Thats gonna be awesome one, I need to buy it"
        
        let item2 = Item(context: context)
        item2.title = "iPhone"
        item2.price = 800
        item2.details = "Thats gonna be awesome one, I need to buy it"
        
        let item3 = Item(context: context)
        item3.title = "iPad"
        item3.price = 500
        item3.details = "Thats gonna be awesome one, I need to buy it"
        
        let item4 = Item(context: context)
        item4.title = "MacBook Pro"
        item4.price = 1500
        item4.details = "Thats gonna be awesome one, I need to buy it"
        
        let item5 = Item(context: context)
        item5.title = "MacBook Pro"
        item5.price = 1500
        item5.details = "Thats gonna be awesome one, I need to buy it"
        
        let item6 = Item(context: context)
        item6.title = "MacBook Pro"
        item6.price = 1500
        item6.details = "Thats gonna be awesome one, I need to buy it"
        
        ad.saveContext()
    }
    
    
    
}

