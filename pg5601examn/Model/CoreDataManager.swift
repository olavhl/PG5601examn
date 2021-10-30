//
//  CoreDataManager.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 30/10/2021.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    // Saving users to CoreData
    func saveUsersToDB(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    // Loading users from CoreData
    func loadUsersFromDB(context: NSManagedObjectContext) -> [UserEntity] {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        var userEntityFetched = [UserEntity]()
        do {
            userEntityFetched = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
        
        return userEntityFetched
    }
}
