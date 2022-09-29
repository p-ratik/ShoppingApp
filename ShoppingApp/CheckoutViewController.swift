//
//  CheckoutViewController.swift
//  ShoppingApp
//
//  Created by Capgemini-DA161 on 9/23/22.
//

import UIKit
import MapKit
import CoreLocation

class CheckoutViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    // MARK: - IBOutlet for CheckOut Page Starts
    @IBOutlet weak var userMapView: MKMapView!
    // MARK: - IBOutlet for CheckOut Page ends
    
    var locManager: CLLocationManager!
    var itemName: String = ""
    var rowNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        determineUserLocation()

    }
    
    // Function to determine Location
    func determineUserLocation() {
        locManager = CLLocationManager()
        locManager.delegate = self
        //setting accuracy
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        //getting permission
        locManager.requestAlwaysAuthorization()
        
        //if access is given
        if CLLocationManager.locationServicesEnabled() {
            //start updating location
            locManager.startUpdatingLocation()
        }
    }
    //method is called when startUpdatingLocation() is called
    var mUserLocation: CLLocation?
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locations array containing location
        let mUserLocations: CLLocation = locations[0] as CLLocation
        mUserLocation = mUserLocations
        //determining center to display using latitude and longitude
        let center = CLLocationCoordinate2D(latitude: mUserLocations.coordinate.latitude, longitude: mUserLocations.coordinate.longitude)
        
        //determining region
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        // setting the region in mapView
        userMapView.setRegion(mRegion, animated: true)
        
        
        //Annotation
        let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
        //setting coordinates
        mkAnnotation.coordinate = CLLocationCoordinate2DMake(mUserLocations.coordinate.latitude, mUserLocations.coordinate.longitude)
       // mkAnnotation.title = "Current Location"
        getAddress { (address) in
            mkAnnotation.title = address
        }
        userMapView.addAnnotation(mkAnnotation)
    }
    
    // Function to get Address
    func getAddress(handler: @escaping (String) -> Void) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mUserLocation!.coordinate.latitude, longitude: mUserLocation!.coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placeMarks, error) -> Void in
            //place details
            var placeMark: CLPlacemark?
            placeMark = placeMarks?[0]
            //address DICTIONARY
            let address = "\(placeMark?.subThoroughfare ?? ""), \(placeMark?.thoroughfare ?? ""), \(placeMark?.locality ?? ""), \(placeMark?.subLocality ?? ""), \(placeMark?.administrativeArea ?? ""), \(placeMark?.postalCode ?? ""), \(placeMark?.country ?? "")"
            handler(address)
        })
    }
    
    // MARK: - IBAction for Checout Screen Starts
    @IBAction func placeOrderButtonClicked(_ sender: Any) {
        let index = Int(rowNumber!)!
        if(DBOperations.sharedInstance.updateDataFromCart(index: index)) {
            self.showOrderPlacedAlert(itemName: itemName, mssg: "Order Placed Successfully!", title: "Congratulations")
        }
        else {
            self.showAlert(title: "Failed", message: "Couldn't Place Order!")
        }
    }
    // MARK: - IBAction for Checout Screen ends
    


}
