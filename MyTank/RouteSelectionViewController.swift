//
//  RouteSelectionViewController.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 20/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire

class RouteSelectionViewController: UIViewController, GMSMapViewDelegate ,  CLLocationManagerDelegate 
{
    // Our View Model for this moduel
    internal let mapsViewModel = RouteSelectionViewModel()
    
    // Our outlets for the map view
    @IBOutlet weak var googleMaps: GMSMapView!
    @IBOutlet weak var startLocation: UITextField!
    @IBOutlet weak var destinationLocation: UITextField!
    @IBOutlet weak var distance: UITextField!
    
    internal var locationManager = CLLocationManager()
    internal var locationSelected = Location.startLocation
    
    internal var locationStart = CLLocation()
    internal var locationEnd = CLLocation()
    
    // On view load...
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        //Map initiation code
        let camera = GMSCameraPosition.camera(withLatitude: -37.809126, longitude: 144.965278, zoom: 15.0)
        
        self.googleMaps.camera = camera
        self.googleMaps.delegate = self
        self.googleMaps?.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last

        
        let locationTujuan = CLLocation(latitude: 37.784023631590777, longitude: -122.40486681461333)
        
        googleMaps = mapsViewModel.createMarker(titleMarker: "Lokasi Tujuan", iconMarker: #imageLiteral(resourceName: "mapspin") , latitude: locationTujuan.coordinate.latitude, longitude: locationTujuan.coordinate.longitude, mapsIn: googleMaps)
        
       googleMaps = mapsViewModel.createMarker(titleMarker: "Lokasi Aku", iconMarker: #imageLiteral(resourceName: "mapspin") , latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, mapsIn: googleMaps)
        
        googleMaps = mapsViewModel.drawPath(startLocation: location!, endLocation: locationTujuan, mapsIn: googleMaps)
        
        self.locationManager.stopUpdatingLocation()
        
    }

    //MARK: - Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error to get location : \(error)")
    }
    
    // MARK: - GMSMapViewDelegate
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition)
    {
        googleMaps.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool)
    {
        googleMaps.isMyLocationEnabled = true
        
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    {
        googleMaps.isMyLocationEnabled = true
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D)
    {
        print("COORDINATE \(coordinate)") // when you tapped coordinate
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool
    {
        googleMaps.isMyLocationEnabled = true
        googleMaps.selectedMarker = nil
        return false
    }
    
    // MARK: when start location tap, this will open the search location
    @IBAction func openStartLocation(_ sender: UIButton) {
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self as GMSAutocompleteViewControllerDelegate
        
        // selected location
        locationSelected = .startLocation
        
        // Change text color
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    // MARK: when destination location tap, this will open the search location
    @IBAction func openDestinationLocation(_ sender: UIButton) {
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self as GMSAutocompleteViewControllerDelegate
        
        // selected location
        locationSelected = .destinationLocation
        
        // Change text color
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    // MARK: SHOW DIRECTION WITH BUTTON
    @IBAction func showDirection(_ sender: UIButton)
    {
        // when button direction tapped, must call drawpath func
        googleMaps = mapsViewModel.drawPath(startLocation: locationStart, endLocation: locationEnd, mapsIn: googleMaps)
    }
}

// MARK: - GMS Auto Complete Delegate, for autocomplete search location
extension RouteSelectionViewController: GMSAutocompleteViewControllerDelegate
{
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error)
    {
        print("Error \(error)")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        // Change map location
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0
        )
        
        // set coordinate to text
        if locationSelected == .startLocation {
            startLocation.text = "\(place.name)"
            locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
          googleMaps = mapsViewModel.createMarker(titleMarker: "Location Start", iconMarker: #imageLiteral(resourceName: "mapspin"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude, mapsIn: googleMaps)
        } else {
            destinationLocation.text = "\(place.name)"
            locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            googleMaps = mapsViewModel.createMarker(titleMarker: "Location End", iconMarker: #imageLiteral(resourceName: "mapspin"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude, mapsIn: googleMaps)
        }
        
        
        self.googleMaps.camera = camera
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

public extension UISearchBar
{
    public func setTextColor(color: UIColor)
    {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
}
