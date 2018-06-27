//
//  MapViewController.swift
//  litres?
//
//  Created by Atanas Chompolov on 27.06.18.
//  Copyright © 2018 Atanas Chompolov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var currentLocationButton: UIButton!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            let userLocation = locationManager.location
            let viewRegion = MKCoordinateRegionMakeWithDistance((userLocation?.coordinate)!, 600, 600)
            self.map.setRegion(viewRegion, animated: true)
        }
        
        // reposition or hide compass in map view
            //let compassButton = MKCompassButton(mapView: map)
            map.showsCompass = false
            //compassButton.frame.origin(x: , y: )
            //compassButton.compassVisibility = .visible
            //view.addSubview(compassButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // get user location and view it on the map
    @IBAction func getUserLocation(_ sender: Any) {
        let userLocation = locationManager.location
        let viewRegion = MKCoordinateRegionMakeWithDistance((userLocation?.coordinate)!, 600, 600)
        self.map.setRegion(viewRegion, animated: true)
    }
    
    //    Updation user location and map view region
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        //let locValue: CLLocationCoordinate2D = manager.location!.coordinate
    //        //print("\(locValue.latitude), \(locValue.longitude)")
    //        let userLocation = locations.last
    //        let viewRegion = MKCoordinateRegionMakeWithDistance((userLocation?.coordinate)!, 600, 600)
    //        self.map.setRegion(viewRegion, animated: true)
    //    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
