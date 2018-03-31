//
//  ViewController.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 5..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func buttonTouchUp(_ sender: UIButton) {
        TripManager.shared.startTrip()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
