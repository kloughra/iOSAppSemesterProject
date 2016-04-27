//
//  ScheduleViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/25/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit
import MapKit

class ScheduleViewController: UIViewController, MKMapViewDelegate {

    
    var lat:Double = 41.708448
    var lng:Double = -86.233047
    
    @IBOutlet weak var stinsonMap: MKMapView!
    @IBOutlet weak var schedulePhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: self.lat, longitude: self.lng)
        centerMapOnLocation(initialLocation)
        let pin = Pin(coordinate: initialLocation.coordinate)
        self.stinsonMap.addAnnotation(pin)
        self.schedulePhoto.contentMode = .ScaleAspectFit
        // Do any additional setup after loading the view.
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        self.stinsonMap.setRegion(coordinateRegion, animated: true)
    }



}
