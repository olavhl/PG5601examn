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
    var firstName: String
    var lastName: String
    let pictureAsData: Data?
    let pictureLargeAsData: Data?
    var email: String
    var entireBirthDate: String
    var phoneNumber: String
    var city: String
    let coordinateLatitude: String
    let coordinateLongitude: String
    var isEdited = false
    
    //MARK: - Computed values to get the exact values needed
    var birthDate: String {
        get {
            let splitDOBIntoArray = entireBirthDate.split(separator: "T")
            return String(splitDOBIntoArray[0])
        }
        set(newBirthdate) {
            self.entireBirthDate = "\(newBirthdate)T21:01:01.833Z"
        }
    }
    
    var age: String {
        get {
            let currentYear = Calendar.current.component(.year, from: Date())
            let birthStringArray = birthDate.split(separator: "-")
            var ageCalculation = 0
            if let birthYearAsString = birthStringArray.first {
                ageCalculation = currentYear - Int(birthYearAsString)!
            }

            return String(ageCalculation)
        }
        set(newAge) {
            let currentYear = Calendar.current.component(.year, from: Date())
            let birthStringArray = birthDate.split(separator: "-")
            var year = 0
            if let unwrappedNewAge = Int(newAge) {
                year = currentYear - unwrappedNewAge
            }
            self.entireBirthDate = "\(year)-\(birthStringArray[1])-\(birthStringArray[2])T21:01:01.833Z"
        }
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
    
    var hasBirthdayWeek: Bool {
        // Changing to the year to 2021 to be able to calculate days between.
        let birthArray = birthDate.split(separator: "-")
        let birthdayThisYear = "2021-\(birthArray[1])-\(birthArray[2])"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let userBirthAsDate = dateFormatter.date(from: birthdayThisYear)
        let dateToday = Date()

        if let userBirth = userBirthAsDate {
            if let daysBetween = Calendar.current.dateComponents([.day], from: userBirth, to: dateToday).day {
                if daysBetween <= 7, daysBetween >= -7 {
                    return true
                }
            }
            
        }
        
        
        
        
        return false
    }
}
