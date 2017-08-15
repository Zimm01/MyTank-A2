//
//  CustomSelectorModuleViewModel.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 14/08/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import CoreData

class CustomSelectorModuleViewModel: MyTankViewModel
{
    // Our Request to fetch the Models from Object Context
    private var fetchThisModelRequest : NSFetchRequest<Vehicle2> = NSFetchRequest(entityName: "Vehicle2")
    
    // Our unconfrimed make and model string from the CoreData Object
    private var unconfirmedMake:String = ""
    private var unconfirmedModel:String = ""
    
    private var modelVehicleList = [Vehicle2]()
    
    // Our variant and series Containers
    private var seriesList = [String]()
    private var variantList = [String]()
    
    // We want to place the values in an array to be used by displayed as in the view
    override init()
    {
        super.init()
        
        // Our persistant container from the CoreData Model
        var objectContext = persistentContainer.viewContext
        
        do
        {
            // Get the make and model from the CoreData Object
            unconfirmedMake = try super.getUncommitedMake(context: &objectContext)
            unconfirmedModel = try super.getUncommitedModel(context: &objectContext)
            
            // We will fetch all vehicles that have this make and model from Core Data
            fetchThisModelRequest.predicate = NSPredicate(format: "make == %@ AND model == %@", unconfirmedMake, unconfirmedModel)
            try modelVehicleList = objectContext.fetch(fetchThisModelRequest) as [Vehicle2]
        }
        catch
        {
            unconfirmedMake = "Error"
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
        
        // We want to populate the series and variant list here
        populateInitialLists(context: &objectContext)

    }
    
    private func populateInitialLists(context: inout NSManagedObjectContext)
    {
        super.makeVehicleListSingletons(vehList: &modelVehicleList, byModel: false)
        
        for mod in modelVehicleList
        {
            print(mod.variant!)
        }
    }
    
    // Return a Combined Make and Model String to a view
    func getMakeModelString() -> String
    {
        return unconfirmedMake + " " + unconfirmedModel
    }
    
    // Return a Combined Make and Model String to a view
    func getMakeString() -> String
    {
        return unconfirmedMake
    }
    
}
