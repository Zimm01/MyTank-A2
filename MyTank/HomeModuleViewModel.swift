//
//  HomeModuleViewModel.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 18/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import CoreData

class HomeModuleViewModel: MyTankViewModel
{
    
    override init()
    {
        super.init()
    }
    
    // Return the vehicle data as a tuple
    func getVehicleData() throws -> (headLine: String, topStr: String, bottomStr: String, imageStr: String)
    {
        let headLineString = "CurrentVehicle"
        var specificVehicleString = ""
        var consumptionString = ""
        var vehicleTypeString = ""
        
        // Our persistant container from the CoreData Model, and our user object
        let objectContext = persistentContainer.viewContext
        let userDataObject = try objectContext.fetch(userDataFetchReq)
        
        // Get the user data so that we can access the vehicle ID
        if let userData = userDataObject.first
        {
            let userVehicleID:Int32 = userData.vehicleID
                
            // Attempt to find the vehicle given by the ID in the vehicle entity
            vehicleFetchReq.predicate = NSPredicate(format: "id == \(userVehicleID)")
            
            // Attempt to fetch the context, if the result contains ONLY ONE entry, it has worked correctly so we can commit that data to the userData object!
            let vehicleResult = try objectContext.fetch(vehicleFetchReq) as [Vehicle2]
            if vehicleResult.count == 1
            {
                let theVehicle = vehicleResult.first
                
                // Get the make model and series variant strings to be combined in the next step
                let makeModel = theVehicle!.make! + " " + theVehicle!.model! + " "
                let seriesVariant = theVehicle!.series! + " " + theVehicle!.variant!
                
                // Set the specific vehicle consumption and image values
                specificVehicleString = makeModel + seriesVariant
                consumptionString = String(theVehicle!.consumptionLitres) + "L/100Km"
                vehicleTypeString = imageForType(bodyType: theVehicle!.type!)
            }
            else{
                throw VehicleError.doesNotExist
            }
        }
        else{
            throw UserDataError.userDataLookupError
        }
        
        return (headLineString, specificVehicleString, consumptionString, vehicleTypeString)
    }
    
    // Return a default set of data to the view, for the case where no vehicle exists
    func getDefaultData() -> (headLine: String, topStr: String, bottomStr: String, imageStr: String)
    {
        // Headline, Top Display String, Bottom Display String and Default Image name in xcasset
        return ("The Fuel Calculator", "A Vehicle Has Not Been Selected", "To Get Started, Tap Below", "HomeThumbDEF")
    }
    
    // Re-assign the selected user's vehicle id to an invalid default number, thus 'deleting' that vehicle
    func deleteCurrentVehicle() throws
    {
        // Our persistant container from the CoreData Model
        let objectContext = persistentContainer.viewContext
        
        let userDataObject = try objectContext.fetch(userDataFetchReq)
            
        // We will attempt to find a valid vehicle ID in the database
        if let userData = userDataObject.first
        {
            // Set the vehicle ID to an invalid number
            userData.setValue(MyTankConstants.invalidID, forKey: "vehicleID")
            try objectContext.save()
        }
        else
        {
            throw UserDataError.userDataLookupError
        }
    }
    
    // Take the value of a body type from a vehicle object and output a corresponding thumbnail string
    private func imageForType(bodyType: String) -> String
    {
        var newBodyType:String = ""

        switch bodyType{
        case BodyTypes.smallCar.rawValue:
            newBodyType = "HomeThumbCSM"
        case BodyTypes.mediumCar.rawValue:
            newBodyType = "HomeThumbCMD"
        case BodyTypes.largeCar.rawValue:
            newBodyType = "HomeThumbCLG"
        case BodyTypes.suvCar.rawValue:
            newBodyType = "HomeThumbSUV"
        case BodyTypes.fwd.rawValue:
            newBodyType = "HomeThumbFWD"
        case BodyTypes.uteCar.rawValue:
            newBodyType = "HomeThumbUTE"
        case BodyTypes.van.rawValue:
            newBodyType = "HomeThumbVAN"
        case BodyTypes.truck.rawValue:
            newBodyType = "HomeThumbTRK"
        default:
            newBodyType = "HomeThumbDEF"
        }
        
        return newBodyType
    }
}
