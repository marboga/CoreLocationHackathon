//
//  FlyViewController.swift
//  MonsteHunter
//
//  Created by Michael Arbogast on 5/18/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit
import MapKit

class FlyViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    var coordinate = CLLocationCoordinate2D(latitude: 47.62083705, longitude: -122.3494944)
    
    let distance: CLLocationDistance = 850
    let pitch: CGFloat = 75
    let heading = 0.0
    var camera: MKMapCamera?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.coordinate)
        //comform to delegate method
        self.locationManager.delegate = self
        //want user exact location
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //only want location when using app
        self.locationManager.requestWhenInUseAuthorization()
        //start looking for location
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        mapView.delegate = self
        
        let request = MKLocalSearchRequest()
        request.region = mapView.region
        
        print(mapView.region.center)
        print(request.region.center)
        
        mapView.mapType = .SatelliteFlyover
        
//        coordinate = mapView.region.center

        camera = MKMapCamera(lookingAtCenterCoordinate: coordinate,
                             fromDistance: distance,
                             pitch: pitch,
                             heading: heading)
        mapView.camera = camera!
        
        animate()
        
        
    }
    
    @IBAction func animateCamera(sender: AnyObject) {
        UIView.animateWithDuration(8.0, animations: {
            self.camera!.heading += 120
            self.camera!.pitch -= 20
            self.mapView.camera = self.camera!
        })
    }
    
    func animate(){
        print(self.coordinate)
        UIView.animateWithDuration(8.0, animations: {
            self.camera!.heading += 120
            self.camera!.pitch -= 20
            self.mapView.camera = self.camera!
        })
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // location delegate metod
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //getting last location that was passed in
        let location = locations.last
        //get center of that location
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        //get the region where the map can zoom to. if zoom is 5, it'll zoom out
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(
            latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        //get zoom animation
        self.mapView.setRegion(region, animated: true)
        print("center2", center)
        self.coordinate = center
        //stop updating location when we got locaiton
        self.locationManager.stopUpdatingLocation()
    }
}


