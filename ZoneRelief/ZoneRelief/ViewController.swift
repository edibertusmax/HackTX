//
//  ViewController.swift
//  ZoneRelief
//
//  Created by Eduardo Pineda on 10/28/17.
//  Copyright © 2017 eebz. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
  
  var locationManager = CLLocationManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view, typically from a nib.
  /*  let camera = GMSCameraPosition.camera(withLatitude: -12.5420, longitude: 27.8546, zoom: 10.0)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    view = mapView*/
    
    // Creates a marker in the center of the map.
    
    /*let reliefCircle = GMSCircle()
    reliefCircle.position = CLLocationCoordinate2D(latitude: -12.5420, longitude: 27.8546)
    reliefCircle.radius = 5000
    reliefCircle.strokeColor = UIColor.red
    reliefCircle.fillColor = UIColor.red.withAlphaComponent(0.5)
    //marker.title = "Sydney"
    //marker.snippet = "Australia"
    reliefCircle.map = mapView*/
    
    // Ask for Authorisation from the User.
    self.locationManager.requestAlwaysAuthorization()
    
    // For use in foreground
    self.locationManager.requestWhenInUseAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
    }
    let camera = GMSCameraPosition.camera(withLatitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude, zoom: 10.0)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    view = mapView
    
    
    /*
    locationManager = CLLocationManager()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestAlwaysAuthorization()
    locationManager.distanceFilter = 50
    locationManager.startUpdatingLocation()
    locationManager.delegate = self*/
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude)
    marker.map = mapView
    
    
    
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    var locValue:CLLocationCoordinate2D = manager.location!.coordinate
    print("locations = \(locValue.latitude) \(locValue.longitude)")
  }


  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

