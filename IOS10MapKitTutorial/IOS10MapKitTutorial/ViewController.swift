//
//  ViewController.swift
//  IOS10MapKitTutorial
//
//  Created by Igor Lantushenko on 01/04/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocationCoordinate2D(latitude: 51.50007773, longitude: -0.1246402)
        
        let span  = MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotaion = MKPointAnnotation()
        annotaion.coordinate = location
        annotaion.title = "Big Ben"
        annotaion.subtitle = "London"
        
        mapView.addAnnotation(annotaion)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

