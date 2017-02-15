//
//  ItemDetailVC.swift
//  DreamList
//
//  Created by Igor Lantushenko on 12/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var itemTypePickerView: UIPickerView!
    @IBOutlet weak var storePickerView: UIPickerView!
    @IBOutlet weak var priceView: CustomTextField!
    @IBOutlet weak var titleView: CustomTextField!
    @IBOutlet weak var descriptionView: CustomTextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var imagePicker: UIImagePickerController!
    var stores: [Store]!
    var itemTypes: [ItemType]!
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navItem = self.navigationController?.navigationBar.topItem {
            navItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }

        itemTypePickerView.delegate = self
        itemTypePickerView.dataSource = self
        
        storePickerView.delegate = self
        storePickerView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        /*let itemType = ItemType(context: context)
        itemType.type = "Phone"
        let itemType1 = ItemType(context: context)
        itemType1.type = "TV"
        let itemType2 = ItemType(context: context)
        itemType2.type = "Car"
        let itemType3 = ItemType(context: context)
        itemType3.type = "Laptop"
        
        //ad.saveContext()
        
        let store = Store(context: context)
        store.name = "Amazone"
        let store1 = Store(context: context)
        store1.name = "eBay"
        let store2 = Store(context: context)
        store2.name = "Rozetka"
        let store3 = Store(context: context)
        store3.name = "Target"
        
        ad.saveContext()*/
        getItemTypes()
        getStores()
        if item != nil {
            prepareView()
        }
    }

    func prepareView() {
        titleView.text = item!.title
        priceView.text = String(item!.price)
        descriptionView.text = item!.details
        
        if let pic = item!.toImage {
            imageView.image = pic.image as! UIImage?
        } else {
            imageView.image = UIImage()
        }
        
        if item!.toStore != nil, let index = stores.index(of: item!.toStore!) {
            storePickerView.selectRow(index, inComponent: 0, animated: true)
        } else {
            storePickerView.selectRow(0, inComponent: 0, animated: true)
        }
        
        if item!.toItemType != nil, let index = itemTypes.index(of: item!.toItemType!) {
            itemTypePickerView.selectRow(index, inComponent: 0, animated: true)
        } else {
            itemTypePickerView.selectRow(0, inComponent: 0, animated: true)
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.restorationIdentifier == "itemType" {
            return itemTypes[row].type
        } else {
            return stores[row].name
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //TODO
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.restorationIdentifier == "itemType" {
            return itemTypes.count
        } else {
            return stores.count
        }
    }

    func getStores(){
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do{
            self.stores = try context.fetch(fetchRequest)
            self.storePickerView.reloadAllComponents()
        } catch {
            let error = error as NSError
            print(error)
        }
    }
    
    func getItemTypes(){
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        
        do{
            self.itemTypes = try context.fetch(fetchRequest)
            self.itemTypePickerView.reloadAllComponents()
        } catch {
            let error = error as NSError
            print(error)
        }
    }

    @IBAction func savePressed(_ sender: Any) {
        let item = self.item == nil ? Item(context: context) : self.item!
        let picture = item.toImage == nil ? Image(context: context) : item.toImage!
        
        if let title = titleView.text {
            item.title = title
        }
        if let description = descriptionView.text {
            item.details = description
        }
        if let price = priceView.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let image = imageView.image {
            picture.image = image
            item.toImage = picture
        }
        
        item.toStore = stores[storePickerView.selectedRow(inComponent: 0)]
        item.toItemType = itemTypes[itemTypePickerView.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func deletePressed(_ sender: Any) {
        if item == nil {
            return
        }
        context.delete(item!)
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imagePickerPressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
