//
//  RouteSelectionViewModel.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 20/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
//
//  RouteChoiceController.swift
//  MyTank
//
//  Created by Joachim McClain on 17/8/17.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire


class RouteSelectionViewModel: MyTankViewModel
{
    
    // MARK: function for create a marker pin on map
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees, mapsIn: GMSMapView) -> GMSMapView
    {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = mapsIn
        
        return mapsIn
    }
    

    //MARK: - this is function for create direction path, from start location to desination location
    func drawPath(startLocation: CLLocation, endLocation: CLLocation, mapsIn: GMSMapView) -> GMSMapView
    {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 4
                polyline.strokeColor = UIColor.red
                polyline.map = mapsIn
            }
        }
        
        return mapsIn
    }
    
    // This functions calculates the distance between the origin and destination
    func getDistance(startLocation: CLLocation, endLocation: CLLocation, mapsIn: GMSMapView) -> GMSMapView
    {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 4
                polyline.strokeColor = UIColor.red
                polyline.map = mapsIn
            }
        }
    
        return mapsIn
    }
    
}
