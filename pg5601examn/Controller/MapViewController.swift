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

class MapViewController: UIViewController {
    var userConverter = UserConverter()
    var coreDataManager = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var users = [UserModel]()
    var selectedId: String?
    var usersEntity = [UserEntity]()
    var customPins = [MKAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // loadUsers depending on which data has been sent to the ViewController
        if users.count == 1 {
            createCustomPins()
            mapView.showAnnotations(customPins, animated: false)
            mapView.setRegion(MKCoordinateRegion(center: users[0].coordinates, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), animated: false)
        } else {
            usersEntity = coreDataManager.loadUsersFromDB(context: context)
            users = userConverter.convertAllToUserModel(from: usersEntity)
            createCustomPins()
            mapView.showAnnotations(customPins, animated: false)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Removing all pins before fetching the last update from CoreData
        mapView.removeAnnotations(customPins)
        customPins.removeAll()
        
        if users.count == 1 {
            createCustomPins()
            mapView.showAnnotations(customPins, animated: false)
            mapView.setRegion(MKCoordinateRegion(center: users[0].coordinates, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), animated: false)
        } else {
            usersEntity = coreDataManager.loadUsersFromDB(context: context)
            users = userConverter.convertAllToUserModel(from: usersEntity)
            createCustomPins()
            mapView.showAnnotations(customPins, animated: false)
        }
    }
    
    func createCustomPins() {
        for user in users {
            let pin = CustomPin(title: user.firstName, subtitle: user.id, coordinates: user.coordinates)
            customPins.append(pin)
        }
    }
}

//MARK: - MKMapViewDelegate & Segue
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for view in views {
            if let currentUser = users.first(where: {$0.id == view.annotation?.subtitle}) {
                view.image = currentUser.picture
            }
            // Preventing extra buble to show up when clicking a pin
            view.canShowCallout = false
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if users.count != 1 {
            if let selectedViewId = view.annotation?.subtitle {
                selectedId = selectedViewId
                performSegue(withIdentifier: "showUserDetailFromMap", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserDetailsViewController {
            destination.userId = selectedId
        }
    }
}
