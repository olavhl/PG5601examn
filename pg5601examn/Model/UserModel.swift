//
//  UserModel.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 21/10/2021.
//

import Foundation
import UIKit
import CoreLocation

// Implementing a new Model to be able to have my own namings for the objects
struct UserModel {
    let id: String
    let firstName: String
    let lastName: String
    let pictureAsData: Data?
    let pictureLargeAsData: Data?
    let email: String
    let entireBirthDate: String
    let phoneNumber: String
    let city: String
    let coordinateLatitude: String
    let coordinateLongitude: String
    
    // Computed values to get the exact values needed
    var birthDate: String {
        let splitDOBIntoArray = entireBirthDate.split(separator: "T")
        return String(splitDOBIntoArray[0])
    }
    
    var age: String {
        let currentYear = Calendar.current.component(.year, from: Date())
        let birthStringArray = birthDate.split(separator: "-")
        var ageCalculation = 0
        if let birthYearAsString = birthStringArray.first {
            ageCalculation = currentYear - Int(birthYearAsString)!
        }
        
        return String(ageCalculation)
    }
    
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(self.coordinateLatitude)!, longitude: Double(self.coordinateLongitude)!)
    }
    
    var picture: UIImage? {
        if let unwrappedPicture = pictureAsData {
            return UIImage(data: unwrappedPicture)
        }
        return nil
    }
    
    var pictureLarge: UIImage? {
        if let unwrappedPicture = pictureLargeAsData {
            return UIImage(data: unwrappedPicture)
        }
        return nil
    }
}
