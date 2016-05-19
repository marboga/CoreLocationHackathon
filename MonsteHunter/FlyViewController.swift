//
//  FlyViewController.swift
//  MonsteHunter
//
//  Created by Michael Arbogast on 5/18/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit
import MapKit

class FlyViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let distance: CLLocationDistance = 850
    let pitch: CGFloat = 75
    let heading = 0.0
    var camera: MKMapCamera?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.mapType = .SatelliteFlyover
        
        let coordinate = CLLocationCoordinate2D(latitude: 47.62083705,
                                                longitude: -122.3494944)
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
}


