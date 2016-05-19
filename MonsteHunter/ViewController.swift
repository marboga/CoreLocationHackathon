//
//  ViewController.swift
//  MonsteHunter
//
//  Created by Michael Arbogast on 5/18/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        request.naturalLanguageQuery = "restaurant"
        request.region = mapView.region
    
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) in
            guard let response = response else {
                print("Search error: \(error)")
                return
            }
            
            for item in response.mapItems {
                // ...
                
                print(item, "ITEM")
                let dropPin = MKPointAnnotation()
                dropPin.coordinate = item.placemark.coordinate
                dropPin.title = "a wild Pokemon appeared..."
                dropPin.subtitle = "(what could it be?)"
//                    dropPin.canShowCallout = true
//                    dropPin.detailCalloutAccessoryView = UIImage(image:UIImage(named:"pika"))
 
                self.mapView.addAnnotation(dropPin)
            }

        }
    }
    
    class CustomPointAnnotation: MKPointAnnotation {
        var imageName: String!
    }
    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        
//        
//        let reuseId = "test"
//        
//        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
//        if anView == nil {
//            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            anView?.canShowCallout = true
//            anView?.rightCalloutAccessoryView = UIButton(type: .System)
//        }
//        else {
//            anView!.annotation = annotation
//        }
//        
//        //Set annotation-specific properties **AFTER**
//        //the view is dequeued or created...
//        
//        let cpa = annotation as! CustomPointAnnotation
//        anView!.image = UIImage(named:"pika")
//        
//        return anView
//    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            as? MKPinAnnotationView {
            dequeuedView.annotation = annotation as MKAnnotation
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: annotation as MKAnnotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            //                view.rightCalloutAccessoryView?.tintColor = UIColor.materialMainGreen
        }
        return view
    }
    
    var selectedAnnotation: MKPointAnnotation!
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            selectedAnnotation = view.annotation as? MKPointAnnotation
            performSegueWithIdentifier("showDetail", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? PopoverController {
            print("IN SEGUE")
            destination.annotation = selectedAnnotation
        }
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
        //stop updating location when we got locaiton
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("errors: " + error.localizedDescription)
    }
    
 
    
}

