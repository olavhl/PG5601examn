//
//  UserManager.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 20/10/2021.
//

import CoreData
import UIKit

protocol UserManagerDelegate {
    func didUpdateUserList(_ userManager: UserManager, userData: [UserEntity])
}

struct UserManager {
    let baseUrl = "https://randomuser.me/api/?results=100&nat=no"
    var delegate: UserManagerDelegate?
    // Accessing context from AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchAllUsers() {
        performRequest(with: baseUrl)
    }
    
    func performRequest(with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let userData = fetchJSON(safeData) {
                        self.delegate?.didUpdateUserList(self, userData: userData)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func fetchJSON(_ data: Data) -> [UserEntity]? {
        do {
            let userData = try JSONDecoder().decode(Users.self, from: data)
            let userResults = userData.results

            var userEntityArray: [UserEntity] = []
            
            for user in userResults {
                let userEntity = UserEntity(context: self.context)
                
                userEntity.id = user.id.value
                userEntity.firstName = user.name.first
                userEntity.lastName = user.name.last
                userEntity.email = user.email
                userEntity.entireBirthDate = user.dob.date
                userEntity.phoneNumber = user.cell
                userEntity.city = user.location.city
                userEntity.coordinateLatitude = user.location.coordinates.latitude
                userEntity.coordinateLongitude = user.location.coordinates.longitude
                userEntity.pictureUrl = user.picture.large
                
                userEntityArray.append(userEntity)
            }
            
            return userEntityArray
        } catch {
            print(error)
            return nil
        }
    }
    
    
    // Method to change the value from entity to UserModel
    // to make it easier to handle images and computed values
//    func convertToUserModel(from userEntity: [UserEntity]) -> [UserModel] {
//        var users = [UserModel]()
//
//        for user in userEntity {
//            let id = user.id ?? "1000"
//            let firstName = user.firstName ?? "Ola"
//            let lastName = user.lastName ?? "Nordmann"
//            let email = user.email ?? "ola@nordmann.no"
//            let birthDate = user.entireBirthDate ?? "1949-05-06T10:58:34.005Z"
//            let phoneNumber = user.phoneNumber ?? "91919191"
//            let city = user.city ?? "Oslo"
//            let coordinateLatitude = user.coordinateLatitude ?? "59.920"
//            let coordinateLongitude = user.coordinateLongitude ?? "10.776"
//            let pictureUrl = user.pictureUrl ?? "https://randomuser.me/api/portraits/women/38.jpg"
//
//            let newUser = UserModel(id: id, firstName: firstName, lastName: lastName, pictureUrl: pictureUrl, email: email, entireBirthDate: birthDate, phoneNumber: phoneNumber, city: city, coordinateLatitude: coordinateLatitude, coordinateLongitude: coordinateLongitude)
//
//            users.append(newUser)
//        }
//
//        return users
//    }
}
