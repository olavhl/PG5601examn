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
    let email: String // results[0].email
    let dob: Dob
    let cell: String // results[0].cell
    let location: Location
}

struct Id: Codable {
    let value: String
}

struct Name: Codable {
    let first: String // results[0].name.first
    let last: String // results[0].name.last
}

struct Picture: Codable {
    let medium: String // results[0].picture.medium
}

struct Dob: Codable {
    let date: String // results[0].dob.date
}

struct Location: Codable {
    let city: String // results[0].location.city
    let coordinates: Coordinates
}

struct Coordinates: Codable {
    let latitude: String // results[0].location.coordinates.latitude
    let longitude: String // results[0].location.coordinates.longitude
}
