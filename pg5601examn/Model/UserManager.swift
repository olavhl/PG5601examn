//
//  UserManager.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 20/10/2021.
//

import Foundation
import UIKit

protocol UserManagerDelegate {
    func didUpdateUserList(_ userManager: UserManager, userData: [UserModel])
}

struct UserManager {
    let baseUrl = "https://randomuser.me/api/?results=100&nat=no"
    var delegate: UserManagerDelegate?
    
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
                //                print(fetchJSON(data!))
            }
            
            task.resume()
        }
    }
    
    func fetchImage(url: URL) -> UIImage? {
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
    
    func fetchJSON(_ data: Data) -> [UserModel]? {
        do {
            let userData = try JSONDecoder().decode(Users.self, from: data)
            let userResults = userData.results
            
            
            var users: [UserModel] = []
            
            for user in userResults {
                let firstName = user.name.first
                let lastName = user.name.last
                let email = user.email
                let birthDate = user.dob.date
                let phoneNumber = user.cell
                let city = user.location.city
                let coordinateLatitude = user.location.coordinates.latitude
                let coordinateLongitude = user.location.coordinates.longitude
                var picture: UIImage?
                
                if let imageUrl = URL(string: user.picture.large) {
                    if let image = fetchImage(url: imageUrl) {
                        picture = image
                    }
                } 

                
                // TODO: Need to fix this nil-check of picture
                let implementedUser = UserModel(firstName: firstName, lastName: lastName, picture: picture!, email: email, birthDate: birthDate, phoneNumber: phoneNumber, city: city, coordinateLatitude: coordinateLatitude, coordinateLongitude: coordinateLongitude)
                
                users.append(implementedUser)
            }
            
            return users
        } catch {
            print(error)
            return nil
        }
        
        
    }
    
}
