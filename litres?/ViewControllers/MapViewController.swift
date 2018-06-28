//
//  MapViewController.swift
//  litres?
//
//  Created by Atanas Chompolov on 27.06.18.
//  Copyright © 2018 Atanas Chompolov. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            let userLocation = locationManager.location
            let camera = GMSCameraPosition.camera(withLatitude: (userLocation?.coordinate.latitude)!, longitude: (userLocation?.coordinate.longitude)!, zoom: 10)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            mapView.mapType = .hybrid
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            view = mapView
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}







