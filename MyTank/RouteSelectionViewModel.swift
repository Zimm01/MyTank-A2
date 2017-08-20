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
    // The 'route has been calculated' flag
    private var routeDoesExist: Bool = false
    
    // Setter/Getter for the routeDoes exist
    var routeFlagSet:Bool
        {
        set{routeDoesExist = routeFlagSet}
        get{return routeDoesExist}
    }
    
    // Objects which hold our location start and end
    private var locationStart = CLLocation()
    private var locationEnd = CLLocation()
    
    // Our Raw Lat and long co-ords of the origin and destination
    private var originCoOrd: String = "@"
    private var destinationCoOrd: String = "@"
    
    // Objects which hold our location start and end
    private var originName: String = "Err"
    private var destinationName: String = "Err"
    
    // Distance Value
    private var routeDistance: Int = 0
    
    // Initialiser
    override init()
    {
        super.init()
    }
    
    // Set the location object value
    func setLocation(locationIn: CLLocation, setFor: Location)
    {
        if setFor == Location.startLocation{
            locationStart = locationIn
        }
        else if setFor == Location.destinationLocation{
            locationEnd = locationIn
        }
    }

    // Set the name of the start/destination locations
    func setPlaceName(placeIn: String, getFor: Location)
    {
        if getFor == Location.startLocation{
           originName  = placeIn
        }
        else if getFor == Location.destinationLocation{
           destinationName = placeIn
        }
    }
    
    // Return the  name of the start/destination locations
    func getPlaceName(getFor: Location) -> String
    {
        if getFor == Location.startLocation{
            return originName
        }
        else if getFor == Location.destinationLocation{
            return destinationName
        }
        return "Error"
    }
    
    // Function to control the setting of co-ordinates
    func setCoords(setFor: Location)
    {
        if setFor == Location.startLocation{
            originCoOrd = "\(locationStart.coordinate.latitude),\(locationStart.coordinate.longitude)"
        }
        else if setFor == Location.destinationLocation{
            destinationCoOrd = "\(locationEnd.coordinate.latitude),\(locationEnd.coordinate.longitude)"
        }
    }
    
    // Are both co-ordinates set?
    func bothCoordsSet() -> Bool
    {
        return ((originCoOrd != "@") && (destinationCoOrd != "@"))
    }
    
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
    func drawPath(mapsIn: GMSMapView) -> GMSMapView
    {
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(originCoOrd)&destination=\(destinationCoOrd)&mode=driving"
        
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
        routeFlagSet = true
        return mapsIn
    }
    
    // Commit Values to user Data
    func commitValuesToDB() -> Bool
    {
        // Our persistant container from the CoreData Model
        let objectContext = persistentContainer.viewContext
        
        do
        {
            let userDataObject = try objectContext.fetch(userDataFetchReq)
            
            if let userData = userDataObject.first
            {
                // Set Start Point
                userData.setValue(originName ,forKey: "userRouteStart")
                // Set End Point 
                userData.setValue(destinationName, forKey: "userRouteEnd")
                // Set Distance
                userData.setValue(routeDistance ,forKey: "userRouteDistance")
            }
            else
            {
                throw UserDataError.userDataLookupError
            }
            
            try objectContext.save()
        }
        catch
        {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
            return false
        }
        
        return true
    }
}
