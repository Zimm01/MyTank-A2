//
//  RouteData.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 28/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
//  This file is used to store our Route Data for the prototype app only (To be Replaced by Maps API)

import Foundation

class RouteData
{
    // Dictionary that contains the route values to be used in the program, for the protype, these values are hard-coded!
    private var routeLibrary = [Route(origin: "Bondi Beach", destination: "Newcastle", distance: 169), Route(origin: "Melbourne", destination: "Barossa Valley", distance: 743), Route(origin: "Brisbane", destination: "Perth", distance: 4309 )]
    
    // Return the number of routes in the routeLibrary
    func getNumRoutes()->Int
    {
        return routeLibrary.count
    }
    
    // Get a route, by index position in the library
    func getRouteFromLibrary(key: Int)->Route
    {
        return routeLibrary[key]
    }
}
