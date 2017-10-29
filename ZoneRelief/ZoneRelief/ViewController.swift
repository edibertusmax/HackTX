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
import TwitterKit
import TwitterCore

class ViewController: UIViewController, CLLocationManagerDelegate {
  
  var locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // This how we'll add the coordinates for people in distress
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
    
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude)
    marker.map = mapView
    
    getTweets()
    
    
    
  }  
   /* Referenced from https://grokswift.com/simple-rest-with-swift/ */
   func getTweets() {
    let client = TWTRAPIClient()
    let statusesShowEndpoint = "https://api.twitter.com/1.1/search/tweets.json?q=%23zonerelief"
    let params = ["id": "10"]
    var clientError : NSError?
    
    let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params, error: &clientError)
    
    client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
      if connectionError != nil {
        print("Error: \(connectionError)")
      }
      
      do {
        let json = try JSONSerialization.jsonObject(with: data!, options: [])
        print("json: \(json)")
      } catch let jsonError as NSError {
        print("json error: \(jsonError.localizedDescription)")
      }
    }
   }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    var locValue:CLLocationCoordinate2D = manager.location!.coordinate
    print("locations = \(locValue.latitude) \(locValue.longitude)")
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
//
//  let search:String = "https://api.twitter.com/1.1/search/tweets.json?q=%23zonerelief";
//  guard let searchURL = URL(string: search) else {
//  print("Error: cannot create URL")
//  return
//  }
//
//  let urlRequest = URLRequest(url: searchURL)
//  let session = URLSession.shared
//  let task = session.dataTask(with: urlRequest) {
//    (data, response, error) in
//    // check for any errors
//    guard error == nil else {
//      print("error calling GET on /todos/1")
//      print(error!)
//      return
//    }
//    // make sure we got data
//    guard let responseData = data else {
//      print("Error: did not receive data")
//      return
//    }
//    // parse the result as JSON, since that's what the API provides
//    do {
//      guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
//        as? [String: Any] else {
//          print("error trying to convert data to JSON")
//          return
//      }
//      // now we have the todo
//      // let's just print it to prove we can access it
//      print("The todo is: " + todo.description)
//
//      // the todo object is a dictionary
//      // so we just access the title using the "title" key
//      // so check for a title and print it if we have one
//      guard let todoTitle = todo["title"] as? String else {
//        print("Could not get todo title from JSON")
//        return
//      }
//      print("The title is: " + todoTitle)
//    } catch  {
//      print("error trying to convert data to JSON")
//      return
//    }
//  }
//  task.resume()
  
}

