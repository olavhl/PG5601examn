//
//  UserManager.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 20/10/2021.
//

import Foundation

struct UserManager {
    let baseUrl = "https://randomuser.me/api/?results=100&nat=no"
    
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
                print(fetchJSON(data!))
            }
            
            task.resume()
        }
    }
    
    func fetchJSON(_ data: Data) -> [UserModel]? {
        do {
            let userData = try JSONDecoder().decode(Users.self, from: data)
            let userResults = userData.results
            
            var users: [UserModel] = []
            
            for user in userResults {
                let firstName = user.name.first
                let lastName = user.name.last
                let picture = user.picture.large
                let email = user.email
                let birthDate = user.dob.date
                let phoneNumber = user.cell
                let city = user.location.city
                let coordinateLatitude = user.location.coordinates.latitude
                let coordinateLongitude = user.location.coordinates.longitude
                
                let implementedUser = UserModel(firstName: firstName, lastName: lastName, picture: picture, email: email, birthDate: birthDate, phoneNumber: phoneNumber, city: city, coordinateLatitude: coordinateLatitude, coordinateLongitude: coordinateLongitude)
                
                users.append(implementedUser)
            }
            
            return users
        } catch {
            print(error)
            return nil
        }
        

    }

}
