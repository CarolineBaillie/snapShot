//
//  ViewController.swift
//  snapShot
//
//  Created by Caroline Baillie on 12/27/20.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBAction func addAnnotation(_ sender: Any) {
        // should pop up different controller so that can enter info
        // For Phone
        let obj = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "picController") as! picController
        self.present(obj, animated: true, completion: nil)
        // For Computer
//        let obj = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newMemory") as! newMemory
//        self.present(obj, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup for function that is called from newMemory
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        // go through all memories in global list
        for m in sessionManager.shared.memories {
            // if there is a mapView (protection)
            if mapView != nil {
                // add that Memory
                mapView.addAnnotation(m)
            }
        }
    }
    // function to reload newMemories bc when dismissed adding controller doesn't show without
    @objc func reload (notification: NSNotification){
        self.mapView.removeAnnotations(self.mapView.annotations)
        for m in sessionManager.shared.memories {
            // if there is a mapView (protection)
            if mapView != nil {
                // add that Memory
                mapView.addAnnotation(m)
            }
        }
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // make sure only right type of pins display
        guard annotation is Memory else {return nil}
        // create identifier for annotation views
        let identifier = "Memory"
        // get back an annotation if it is one with identifier, otherwise nil
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            //create button - i button for info
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // if have in dq go ahead and use
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // make sure is type Memory
        guard let memory = view.annotation as? Memory else {return}
        if control == view.rightCalloutAccessoryView {
            // go to info page for that memory
            let obj = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "memInfoPage") as! memInfoPage
            // pass memory information
            obj.page = memory
            obj.map = true
            self.present(obj, animated: true, completion: nil)
       }
    }
    
}

