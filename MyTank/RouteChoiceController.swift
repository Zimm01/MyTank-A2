//
//  RouteChoiceController.swift
//  MyTank
//
//  Created by Joachim McClain on 17/8/17.
//  Copyright © 2017 CPT224. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class RouteChoiceController: UIViewController {
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    GMSServices.provideAPIKey("AIzaSyDn4HbeG-30easqT4dwhVaqPWZ1gSEk_T4")
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
}