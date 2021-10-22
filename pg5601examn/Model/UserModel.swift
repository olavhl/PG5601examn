//
//  UserModel.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 21/10/2021.
//

import Foundation
import UIKit

// Implementing a new Model to be able to have my own namings for the objects
struct UserModel {
    let firstName: String
    let lastName: String
    let picture: UIImage
    let email: String
    let entireBirthDate: String
    let phoneNumber: String
    let city: String
    let coordinateLatitude: String
    let coordinateLongitude: String
    
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
}
