//
//  MapViewController.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 23/10/2021.
//

import UIKit
import MapKit
import CoreData
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    var userConverter = UserConverter()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var users = [UserModel]()
    var usersEntity = [UserEntity]()
    var customPins = [MKAnnotation]()
    
    let map = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsersFromDB()
        
        view.addSubview(map)
        map.frame = view.bounds
        map.delegate = self
        
        createCustomPins()
        map.showAnnotations(customPins, animated: false)
        
    }
    
    
    func createCustomPins() {
        for user in users {
            let pin = CustomPin(title: user.firstName, subtitle: user.id, coordinates: user.coordinates)
            customPins.append(pin)
        }
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for view in views {
            if let currentUser = users.first(where: {$0.id == view.annotation?.subtitle}) {
                view.image = currentUser.picture
            }
            // Preventing extra buble to show up when clicking a pin
            view.canShowCallout = false
        }
    }
    
    // Loading users from CoreData
    func loadUsersFromDB() {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            usersEntity = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
        users = userConverter.convertAllToUserModel(from: usersEntity)
        
    }
}
