//
//  UserConverter.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 24/10/2021.
//

import Foundation

struct UserConverter {
    // Method to change the value from entity to UserModel
    // to make it easier to handle images and computed values
    func convertAllToUserModel(from userEntity: [UserEntity]) -> [UserModel] {
        var users = [UserModel]()
        
        for user in userEntity {
            let id = user.id ?? "1000"
            let firstName = user.firstName ?? "Ola"
            let lastName = user.lastName ?? "Nordmann"
            let email = user.email ?? "ola@nordmann.no"
            let birthDate = user.entireBirthDate ?? "1949-05-06T10:58:34.005Z"
            let phoneNumber = user.phoneNumber ?? "91919191"
            let city = user.city ?? "Oslo"
            let coordinateLatitude = user.coordinateLatitude ?? "59.920"
            let coordinateLongitude = user.coordinateLongitude ?? "10.776"
            let pictureUrl = user.pictureAsData ?? nil
            let pictureLargeAsData = user.pictureLargeAsData ?? nil
            
            let newUser = UserModel(id: id, firstName: firstName, lastName: lastName, pictureAsData: pictureUrl, pictureLargeAsData: pictureLargeAsData, email: email, entireBirthDate: birthDate, phoneNumber: phoneNumber, city: city, coordinateLatitude: coordinateLatitude, coordinateLongitude: coordinateLongitude)
            
            users.append(newUser)
        }
        
        return users
    }
    
    func convertSingleUserModel(from userEntity: UserEntity) -> UserModel {
        let id = userEntity.id ?? "1000"
        let firstName = userEntity.firstName ?? "Ola"
        let lastName = userEntity.lastName ?? "Nordmann"
        let email = userEntity.email ?? "ola@nordmann.no"
        let birthDate = userEntity.entireBirthDate ?? "1949-05-06T10:58:34.005Z"
        let phoneNumber = userEntity.phoneNumber ?? "91919191"
        let city = userEntity.city ?? "Oslo"
        let coordinateLatitude = userEntity.coordinateLatitude ?? "59.920"
        let coordinateLongitude = userEntity.coordinateLongitude ?? "10.776"
        let pictureUrl = userEntity.pictureAsData ?? nil
        let pictureLargeAsData = userEntity.pictureLargeAsData ?? nil
        
        return UserModel(id: id, firstName: firstName, lastName: lastName, pictureAsData: pictureUrl, pictureLargeAsData: pictureLargeAsData, email: email, entireBirthDate: birthDate, phoneNumber: phoneNumber, city: city, coordinateLatitude: coordinateLatitude, coordinateLongitude: coordinateLongitude)
    }
}
