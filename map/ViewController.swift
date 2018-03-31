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
    @IBOutlet weak var saveFileButton: UIButton!
    
    @IBAction func buttonTouchUp(_ sender: UIButton) {
        if TripManager.shared.currentTrip == nil {
            TripManager.shared.startTrip()
            startButton.setTitle("END", for: UIControlState.normal)
        } else {
            TripManager.shared.endTrip()
            startButton.setTitle("START", for: UIControlState.normal)
        }
    }
    
    @IBAction func saveFileButtonTouchUp(_ sender: UIButton) {
        if let title = saveFileButton.titleLabel?.text {
            if title == "SAVE FILE" {
                SaveFileTest.share.saveFile()
                showAlert(title: "File save", message: "File saved. Go to check it out.")
                saveFileButton.setTitle("CHECK FILE", for: UIControlState.normal)
            } else {
                showAlert(title: "File read", message: SaveFileTest.share.readFile())
                saveFileButton.setTitle("SAVE FILE", for: UIControlState.normal)
            }
        }
    }
    
    func showAlert(title _title: String, message _message: String) {
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
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
