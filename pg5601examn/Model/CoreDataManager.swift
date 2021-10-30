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
    
    // Loading all users from CoreData
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
    
    // Loading single User from CoreData
    func loadSingleUserFromDB(context: NSManagedObjectContext, userId: String) -> [UserEntity] {
        var userEntityFetched = [UserEntity]()
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        // Searching for the User with ID == userId, which is gotten through segue
        request.predicate = NSPredicate(format: "id = %@", userId)
        do {
            userEntityFetched = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
        
        return userEntityFetched
    }
}
