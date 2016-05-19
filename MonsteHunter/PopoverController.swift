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
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    
    var nameArray = ["Pikachuu", "Brain in a Jar", "Pirandha Bag", "Gelatinous Cube"]
    
    var dicto: [[AnyObject]] = [["Pikachuu", 100, "Electric"],["Brain in a Jar", 250, "Psychic"],["Pirandha Bag", 70, "Leather"],["Gelatinous Cube", 500, "Jelly"]]
    
    let imageArray = ["pika", "jarby", "piradha", "gelatinous_cube"]
    
    let randNum = Int(arc4random_uniform(3))
    
    var allowCatches = false
    var canAttack = true
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allowCatches = false
        
        imageOutlet.image = UIImage(named: "\(imageArray[randNum])")
        nameLabel.text = "\(dicto[randNum][0])"
        healthLabel.text = "Health: \(dicto[randNum][1])"
        typeLabel.text = "Type: \(dicto[randNum][2])"
        
        switch typeLabel.text! {
            case "Electric":
                typeLabel.backgroundColor = UIColor.yellowColor()
                typeLabel.textColor = UIColor.blackColor()
            case "Leather":
                typeLabel.backgroundColor = UIColor.brownColor()
                typeLabel.textColor = UIColor.yellowColor()
            case "Jelly":
                typeLabel.backgroundColor = UIColor.greenColor()
                typeLabel.textColor = UIColor.whiteColor()
            default:
                typeLabel.textColor = UIColor.brownColor()
        }
    }
    
    @IBAction func runAwayAction(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func fightButtonPressed(sender: UIButton) {
        if canAttack == true {
            let attackNum: Int = Int(arc4random_uniform(35) + 4)
            
            let life = dicto[randNum][1]
            print(life)
            
            let remainingLife: Int = Int(life as! NSNumber) - attackNum
            if remainingLife > 0 {
                healthLabel.text = "Health: \(remainingLife)"
                print(remainingLife, "Remaining Life")
                dicto[randNum][1] = remainingLife
                if remainingLife < 50 {
                    allowCatches = true
                    healthLabel.textColor = UIColor.redColor()
                }
               if remainingLife < 0 {
//                    print("You killed it.")
//                    dicto[randNum][1] = remainingLife
//                    allowCatches = false
//                    canAttack = false
//                    nameLabel.text = "You killed it..."
                }
            } else {
                print("You killed it.")
                dicto[randNum][1] = remainingLife
                allowCatches = false
                canAttack = false
                healthLabel.text = "Health: 0"
                nameLabel.text = "You killed it..."
//                var timer = NSTimer()
//                let delay = 1.5
//                timer = NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
    }
    

//    func delayedAction() {
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
    @IBAction func ballButtonPressed(sender: UIButton) {
        if allowCatches == true {
            nameLabel.text = "Caught a \(dicto[randNum][0])!"
            canAttack = false
        }
    }
    
    
}
