//
//  ViewController.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 5..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var startButton: UIButton!
    
    var points:[CLLocationCoordinate2D] = []
    @IBAction func buttonTouchUp(_ sender: UIButton) {
        if TripManager.shared.currentTrip == nil {
            TripManager.shared.startTrip(viewController: self)
            startButton.setTitle("END", for: UIControlState.normal)
        } else {
            TripManager.shared.endTrip()
            points.removeAll()
            startButton.setTitle("START", for: UIControlState.normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        map.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.cyan
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    func save(location: CLLocationCoordinate2D) {
        // We need to implement span values based on speed.
        let span = MKCoordinateSpanMake(0.0275, 0.0275)
        let region = MKCoordinateRegionMake(location, span)

        self.map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        points.append(location)

        let polyline = MKPolyline(coordinates: &points, count: points.count)
        self.map.add(polyline)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
