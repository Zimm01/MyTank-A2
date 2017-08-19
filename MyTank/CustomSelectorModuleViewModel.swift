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
    // Our unconfrimed make and model string from the CoreData Object
    private var unconfirmedMake:String = ""
    private var unconfirmedModel:String = ""
    
    private var modelVehicleList = [Vehicle2]()
    
    // Our variant container
    private var seriesList = [String]()
    private var variantList = [String]()
    
    // Our Currently Selected Vehicle specifics
    private var currentSeriesName: String = ""
    private var currentVariantName: String = ""
    
    // The special year values
    private var specialYearVal: Int16 = 1

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
            vehicleFetchReq.predicate = NSPredicate(format: "make == %@ AND model == %@", unconfirmedMake, unconfirmedModel)
            try modelVehicleList = objectContext.fetch(vehicleFetchReq) as [Vehicle2]
        }
        catch
        {
            unconfirmedMake = "Error"
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
        
        // We want to populate the series and variant list here
        populateInitialLists()
    }
    
    // Setup the Vehicle list and the subsequent variant list, which changes from series to series
    private func populateInitialLists()
    {
        var tempList = modelVehicleList
        
        // Create a list of single series entries and then place those series names into a string array
        super.makeVehicleListSingletons(vehList: &tempList, sortBy: VehicleSortProperties.series)
        for thisVehicle in tempList
        {
            seriesList.append(thisVehicle.series!)
        }
        
        // Set our current series as the first entry
        currentSeriesName = seriesList[0]
        
        // Finally we will populate the list of variants
        populateVariantListFromSeries(thisSeriesStr: currentSeriesName, firstRun: true)
    }
    
    //
    private func populateVariantListFromSeries(thisSeriesStr: String, firstRun: Bool = false)
    {
        variantList.removeAll()
        
        // Create a list of variants based on the currently selected series
        for thisVehicle in modelVehicleList
        {
            if thisSeriesStr == thisVehicle.series!
            {
                variantList.append(thisVehicle.variant!)
            }
        }
        
        // IF this our first run, we want to set our selected variant to the first entry on the list
        if (firstRun){
            currentVariantName = variantList[0]
        }
    }
    
    // Return a string that is either the MAKE, MODEL otherwise it is a combination of both
    func getVehicleString(type: VehicleSortProperties) -> String
    {
        // TODO: find a more eloquant way to express this!
        switch type{
        case VehicleSortProperties.make:
            return unconfirmedMake
        case VehicleSortProperties.model:
            return unconfirmedModel
        case VehicleSortProperties.series:
            return currentSeriesName
        case VehicleSortProperties.variant:
            return currentVariantName
        default:
            break
        }
        
        return unconfirmedMake + " " + unconfirmedModel
    }
    
    // Return the string for a row given by the Index
    func getStringForRow(index: Int, forVar: VehicleSortProperties) -> String
    {
        return forVar == VehicleSortProperties.series ? seriesList[index] : variantList[index]
    }
    
    // Return the number of rows in either array
    func getNumOfRows(forVar: VehicleSortProperties) -> Int
    {
        return forVar == VehicleSortProperties.series ? seriesList.count : variantList.count
    }
    
    // Returns a tuple of statistic values for a given vehicle, including the yearToYear,consumption and engineSize
    func getVehicleStatistics() throws -> (yearToYear: String, consumption: String, engineSize: String)
    {
        var yearVal: String = ""
        var consump: String = ""
        var engine: String = ""
        
        // Set the vehicle given by the current series and variant, may fail if an error setting these values has somehow occured, if so an exception is thrown
        if let vehicleToUse = modelVehicleList.lazy.first(where: {($0.series! == currentSeriesName) && ($0.variant! == currentVariantName)})
        {
            let yearFrom = vehicleToUse.yearStart
            let yearToRaw = vehicleToUse.yearEnd
            var yearToFinal = ""
            
            // If our year to final is the special value '1' then we need to set the value as "Present" to represent the series has not ended
            yearToFinal = yearToRaw == 1 ? "Present" : String(yearToRaw)

            // Set the other values, given by the Vehicle object
            yearVal = String(yearFrom) + " To " + String(yearToFinal)
            consump = String(vehicleToUse.consumptionLitres) + "L/100Km"
            engine = String(vehicleToUse.engineSizeLitres) + "L"
        }
        else{
            throw VehicleError.doesNotExist
        }
        
        return (yearVal,consump,engine)
    }
    
    // Update the current series or variant data, based on what has been selected in the view
    func updateVehicleSpecs(index: Int, forSection: VehicleSortProperties)
    {
        if forSection == VehicleSortProperties.series
        {
            currentSeriesName = seriesList[index]
        }
        else if forSection == VehicleSortProperties.variant
        {
            currentVariantName = variantList[index]
        }
        else{
            currentSeriesName = seriesList[0]
            currentVariantName = variantList[0]
        }
    }
    
    // Update the variant list based on the series that has now been selected
    func changeVehicleSeries(toSeriesIndex: Int)
    {
        populateVariantListFromSeries(thisSeriesStr: seriesList[toSeriesIndex])
    }
}
