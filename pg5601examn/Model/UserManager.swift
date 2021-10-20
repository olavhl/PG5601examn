//
//  UserManager.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 20/10/2021.
//

import Foundation

struct UserManager {
    let baseUrl = "https://randomuser.me/api/?results=100&nat=no"
    
    func getUsers() {
        if let url = URL(string: baseUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                let dataAsString = String(data: data!, encoding: .utf8)
                print(dataAsString)
            }
            task.resume()
        }
        
    }
}
