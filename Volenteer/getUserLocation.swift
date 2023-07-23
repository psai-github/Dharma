//
//  getUserLocation.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/15/23.
//

import Foundation
import Foundation
import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }
    
    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
   
    }
}

func getAdress(){
    let locationManager = CLLocationManager()
    locationManager.requestWhenInUseAuthorization()
    var currentLoc: CLLocation!
    if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
       CLLocationManager.authorizationStatus() == .authorizedAlways) {
        currentLoc = locationManager.location
        print(currentLoc.coordinate.latitude)
        print(currentLoc.coordinate.longitude)
        //    var locationManager = CLLocationManagerDelegate()
        //    locationManager.requestWhenInUseAuthorization()
        //    locationManager.startUpdatingLocation()
        //    print("Your location: \(location?.latitude), \(location?.longitude)")
        lazy var geocoder = CLGeocoder()
        let adress_loc = CLLocation(latitude:currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
        
        // Geocode Location
        geocoder.reverseGeocodeLocation(adress_loc) { (placemarks, error) in
            // Process Response
            mylocation=(placemarks?.first?.postalCode)!
            ContentView().zipcode = (placemarks?.first?.postalCode)!
            
        }
        
        
    }
}

//
//public class Location: NSObject {
//
//
//
//
//  public override init() {
//    super.init()
//    locationManager.delegate = self
//  }
//
//  func loadWeatherData(){
////    self.completionHandler = completionHandler
//    locationManager.requestWhenInUseAuthorization()
//    locationManager.startUpdatingLocation()
//  }
//
//}
//
//extension Location: CLLocationManagerDelegate {
//  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    guard let location = locations.first else { return }
//      print(location.coordinate)
//      getAdress(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
//
//  }
//
//  public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//    print("Error: \(error.localizedDescription)")
//  }
//
//}
//
