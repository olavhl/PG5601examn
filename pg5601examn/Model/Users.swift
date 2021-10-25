//
//  UserData.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 20/10/2021.
//

import Foundation

struct Users: Codable {
    let results: [UserData]
}

struct UserData: Codable {
    let id: Id
    let name: Name
    let picture: Picture
    let email: String
    let dob: Dob
    let cell: String
    let location: Location
}

struct Id: Codable {
    let value: String
}

struct Name: Codable {
    let first: String
    let last: String
}

struct Picture: Codable {
    let medium: String
    let large: String
}

struct Dob: Codable {
    let date: String
}

struct Location: Codable {
    let city: String
    let coordinates: Coordinates
}

struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}
