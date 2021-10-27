//
//  CustomPin.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 25/10/2021.
//

import Foundation
import MapKit

class CustomPin: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinates: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinates
    }
}
