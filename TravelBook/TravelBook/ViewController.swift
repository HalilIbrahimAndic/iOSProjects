//
//  ViewController.swift
//  TravelBook
//
//  Created by Halil Ibrahim Andic on 12.02.2023.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    
    var locationManager = CLLocationManager()  // User location
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //consumes too much battery in Best
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(gestureRecognizer)
  
    }
    
    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer) {
        
            if gestureRecognizer.state == .began {
                let touchedPoint = gestureRecognizer.location(in: self.mapView)
                let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)

                chosenLatitude = touchedCoordinates.latitude
                chosenLongitude = touchedCoordinates.longitude
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = touchedCoordinates
                annotation.title = nameText.text
                annotation.subtitle = commentText.text
                self.mapView.addAnnotation(annotation)
            }
            
        }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // initialize the first location
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        //zoom
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        //region
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        newPlace.setValue(nameText.text, forKey: "title")
        newPlace.setValue(commentText.text, forKey: "subtitle")
        newPlace.setValue(chosenLatitude, forKey: "latitude")
        newPlace.setValue(chosenLongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
    }
    

}

