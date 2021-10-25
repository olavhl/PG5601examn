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
    // Temporary NY coordinate
    let coordinate = CLLocationCoordinate2DMake(40.728, -74)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsersFromDB()
        
        view.addSubview(map)
        map.frame = view.bounds
        map.delegate = self
        createCustomPins()
        
        map.showAnnotations(customPins, animated: false)
        
//        addUserToAnnotations(users: users)
    }
    
    
    func createCustomPins() {
        for user in users {
            let pin = CustomPin(title: user.firstName, coordinates: user.coordinates)
            customPins.append(pin)
        }
    }
    
//    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
//        mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
//        for user in users {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(user.coordinateLatitude)!, longitude: Double(user.coordinateLongitude)!)
//            for view in views {
//                view.image = user.picture
//            }
//        }
//    }

    // Loading users from CoreData
    func loadUsersFromDB() {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            usersEntity = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
        users = userConverter.convertToUserModel(from: usersEntity)
        
    }
}
