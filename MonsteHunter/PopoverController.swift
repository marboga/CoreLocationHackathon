//
//  PopoverController.swift
//  MonsteHunter
//
//  Created by Michael Arbogast on 5/18/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit
import MapKit

class PopoverController: UIViewController {
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    var annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HAIIII")
        imageOutlet.image = UIImage(named: "pika")
    }
    
    @IBAction func runAwayAction(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
}
