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
                showAlert(title: "Where you want to put in", message: "Select where the file will be put into. Do you want the file will be shown on \"Files\" app?", type: AlertType.CHOICE, actionUpTitle: "Shown", actionDownTitle: "Not Shown")
            } else {
                showAlert(title: "File read", message: SaveFileTest.share.readFile())
                saveFileButton.setTitle("SAVE FILE", for: UIControlState.normal)
            }
        }
    }
    
    func showAlert(title _title: String, message _message: String, type _type: AlertType = AlertType.INFO, actionUpTitle upTitle: String = "", actionDownTitle downTitle: String = "") {
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: .alert)
        
        switch (_type) {
        case AlertType.INFO:
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            break;
        case AlertType.CHOICE:
            if !upTitle.isEmpty && !downTitle.isEmpty {
                alert.addAction(UIAlertAction(title: upTitle, style: .default,
                    handler: { action in
                        DispatchQueue.main.async {
                            self.share(url: SaveFileTest.share.fileShareURL)
                        }
                }))
                alert.addAction(UIAlertAction(title: downTitle, style: .default,
                    handler: { action in
                        SaveFileTest.share.saveFile()
                        self.showAlert(title: "File save", message: "File saved. Check it out.")
                        self.saveFileButton.setTitle("CHECK FILE", for: UIControlState.normal)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            } else {
                return
            }
        }
        
        self.present(alert, animated: true)
    }
    
    func share(url: URL) {
        let documentInteractionController = UIDocumentInteractionController()
        
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentOptionsMenu(from: view.frame, in: view, animated: true)
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

// TODO: DEBUG: Needs to be refactoring-ed.
enum AlertType {
    case INFO
    case CHOICE
}

extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}
