//
//  UserData.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 20/10/2021.
//

import Foundation

struct UserData: Codable {
    let name: Name
    let picture: Picture
    let email: String // results[0].email
    let dob: Dob
    let cell: String // results[0].cell
    let location: Location
}

struct Name: Codable {
    let first: String // results[0].name.first
    let last: String // results[0].name.last
}

struct Picture: Codable {
    let large: String // results[0].picture.large
}

struct Dob: Codable {
    let date: String // results[0].dob.date
}

struct Location: Codable {
    let city: String // results[0].location.city
    let coordinates: String
}

struct Coordinates: Codable {
    let latitude: String // results[0].location.coordinates.latitude
    let longitude: String // results[0].location.coordinates.longitude
}
