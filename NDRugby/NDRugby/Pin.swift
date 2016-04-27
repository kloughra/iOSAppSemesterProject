//
//  Pin.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/26/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
}
