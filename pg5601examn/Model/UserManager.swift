//
//  UserManager.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 20/10/2021.
//

import CoreData
import UIKit

protocol UserManagerDelegate {
    func didUpdateUserList(_ userManager: UserManager, userData: [UserModel])
}

struct UserManager {
    let baseUrl = "https://randomuser.me/api/?results=100&nat=no"
    var delegate: UserManagerDelegate?
    // Accessing context from AppDelegate
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
    
    func fetchJSON(_ data: Data) -> [UserModel]? {
        do {
            let userData = try JSONDecoder().decode(Users.self, from: data)
            let userResults = userData.results
//            let userToContext = UserEntity(context: self.context)
            
            
            var users: [UserModel] = []
            
            for user in userResults {
                let id = user.id.value
                let firstName = user.name.first
                let lastName = user.name.last
                let email = user.email
                let birthDate = user.dob.date
                let phoneNumber = user.cell
                let city = user.location.city
                let coordinateLatitude = user.location.coordinates.latitude
                let coordinateLongitude = user.location.coordinates.longitude
                let pictureUrl = user.picture.large
                
                let implementedUser = UserModel(id: id, firstName: firstName, lastName: lastName, pictureUrl: pictureUrl, email: email, entireBirthDate: birthDate, phoneNumber: phoneNumber, city: city, coordinateLatitude: coordinateLatitude, coordinateLongitude: coordinateLongitude)
//                userToContext.
                users.append(implementedUser)
            }
            
            return users
        } catch {
            print(error)
            return nil
        }
    }
    
//        func saveUsersToCoreData() {
//            do {
//                try context.save()
//            } catch {
//                print("Error saving context: \(error)")
//            }
//        }
}
