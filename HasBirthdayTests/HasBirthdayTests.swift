//
//  HasBirthdayTests.swift
//  HasBirthdayTests
//
//  Created by Olav Hartwedt Larsen on 31/10/2021.
//

import XCTest

@testable import pg5601examn

class HasBirthdayTests: XCTestCase {

    func testHasBirthday() {
        let date = Date()
        let dateFormantter = DateFormatter()
        dateFormantter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateAsString = dateFormantter.string(from: date)
        print(dateAsString)
        
        let user = UserModel(id: "0", firstName: "Ola", lastName: "Normann", pictureAsData: Data(), pictureLargeAsData: Data(), email: "ola@normann.no", entireBirthDate: dateAsString, phoneNumber: "91919191", city: "Oslo", coordinateLatitude: "10", coordinateLongitude: "10")
        
        XCTAssertTrue(user.hasBirthdayWeek)
    }
    
    func testDontHaveBirthday() {
        let date = Date()
        let dateFormantter = DateFormatter()
        dateFormantter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        var dateAsString = dateFormantter.string(from: date)

        let dateSplitByT = dateAsString.split(separator: "T")
        let dateProperties = dateSplitByT[0].split(separator: "-")

        let monthToInt = Int(dateProperties[1])

        if let unwrappedMonth = monthToInt {
            let lastMonth = "\(unwrappedMonth - 1)"
            dateAsString = "\(dateProperties[0])-\(lastMonth)-\(dateProperties[2])T\(dateSplitByT[1])"
        }
        let user = UserModel(id: "0", firstName: "Ola", lastName: "Normann", pictureAsData: Data(), pictureLargeAsData: Data(), email: "ola@normann.no", entireBirthDate: dateAsString, phoneNumber: "91919191", city: "Oslo", coordinateLatitude: "10", coordinateLongitude: "10")
        
        XCTAssertFalse(user.hasBirthdayWeek)
    }

}
