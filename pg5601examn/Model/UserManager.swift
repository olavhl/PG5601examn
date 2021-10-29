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
    func didFailWithError(error: Error)
}

struct UserManager {
    let baseUrl = "https://randomuser.me/api/?results=100&nat=no"
    var delegate: UserManagerDelegate?
    // Accessing context from AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchAllUsers(_ seed: String) {
        let urlString = "\(baseUrl)&seed=\(seed)"
        performRequest(with: urlString)
    }
    
    func performRequest(with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
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
                userEntity.isEdited = false
                
                if let imageURL = URL(string: user.picture.medium) {
                    userEntity.pictureAsData = fetchImage(url: imageURL)
                }
                
                if let imageLargeURL = URL(string: user.picture.large) {
                    userEntity.pictureLargeAsData = fetchImage(url: imageLargeURL)
                }
                
                userEntityArray.append(userEntity)
            }
            
            return userEntityArray
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func fetchImage(url: URL) -> Data? {
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                return image.pngData()
            }
        }
        return nil
    }
}
