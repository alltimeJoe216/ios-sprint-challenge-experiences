//
//  ViewController.swift
//  Experiences
//
//  Created by Joe Veverka on 7/10/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    //MARK: -Class Properties
    
    var experienceController = ExperienceController()
    let locationManager = CLLocationManager()
    var touchLocation: CLLocationCoordinate2D?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    viewWillAppear(_ animated: Bool) {
        mapView.addAnnotations(experienceController.experiences)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

