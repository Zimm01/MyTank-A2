//
//  AppDelegate.swift
//  MyTank
//
//  Created by Daniel Zimmerman on 21/06/2017.
//  Copyright © 2017 CPT224. All rights reserved.
//
import UIKit
import CoreData
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // The UI window placeholder
    var window: UIWindow?

    var googleAPIKey = "AIzaSyDNW6sQwxniUrt5CWIsPBrnlRFuygL4WY0"
    
    // User defaults constant
    let defaults = UserDefaults.standard
    
    // OUR VEHICLE JSON FILE!
    let JSONFile = Bundle.main.url(forResource: "VehicleList", withExtension: "json")
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(googleAPIKey)
        GMSPlacesClient.provideAPIKey(googleAPIKey)
        
        // First, check the CURRENT JSON data has not previously been loaded into the database
        // if it has we can skip preloading this information
        if !startupLoadCheck()
        {
            // Our tests have failed, so we will wipe and re-load the vehicle database and user data!
            wipeData(fetchRequest: NSFetchRequest<Vehicle>(entityName: "Vehicle") as! NSFetchRequest<NSFetchRequestResult>)
            wipeData(fetchRequest: NSFetchRequest<VehicleMakes>(entityName: "VehicleMakes") as! NSFetchRequest<NSFetchRequestResult>)
            wipeData(fetchRequest: NSFetchRequest<UserData>(entityName: "UserData") as! NSFetchRequest<NSFetchRequestResult>)
            preloadVehicleData()

            // TODO function that removes user vehicle!
        }
        
        // Validate the user's Data is correctly loaded
        userDataValidate()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication)
    {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
       // self.saveContext()
    }
    
    // This function tests to see if the most recent JSON datafile has been loaded into CoreData and returns true only if this is the case.
    private func startupLoadCheck() -> Bool
    {
        // First, if the database is NOT preloaded, or the size of the file previously used is non existant return false straight away
        if !defaults.bool(forKey: UserKeys.preLoaded.rawValue) || defaults.double(forKey: UserKeys.vehicleFileSize.rawValue) == 0{
            return false
        }
        
        // If the database has been preloaded, we want to check the size of the file used to do so
        // If it is a different size, it will contain different data
        if let file = JSONFile
        {
            do{
                let filesize = try FileManager.default.attributesOfItem(atPath: file.path)[FileAttributeKey.size] as! Double
                
                if filesize != defaults.double(forKey: UserKeys.vehicleFileSize.rawValue){
                    return false
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        return true
    }

    // This funtion takes a Vehicle JSON file and adds it to CoreData
    private func preloadVehicleData()
    {
        // Open the object context and prepare a path to insert data
        let managedObjectContex = persistentContainer.viewContext
        let vehicleEntityDesc = NSEntityDescription.entity(forEntityName: "Vehicle", in: managedObjectContex)
        let makeListDesc = NSEntityDescription.entity(forEntityName: "VehicleMakes", in: managedObjectContex)
        
        // Our dynamic ID will be used as a "key" for DB interaction
        var dynamicId:Int32 = 0
        
        // We will attempt to serialize the JSON file and then add it to the corresponding Data Entity
        do
        {
            if let file = JSONFile
            {
                let data = try Data(contentsOf: file)
                let parsedData = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                
                // Parse the file as dictionary of objects
                if let serializedData = parsedData?["vehicles"] as? [[String:Any]]
                {
                    // This List will hold our make data for the time being
                    var makeList: [String] = []
                    
                    // FOR EACH entry in the file, we will parse it into a Vehicle Entity
                    for dictionary in serializedData
                    {
                        let vehicleData = Vehicle(entity: vehicleEntityDesc! , insertInto: managedObjectContex)
                        
                        vehicleData.setValue(dynamicId, forKey: "id")
                        vehicleData.setValue(dictionary["make"], forKey: "make")
                        vehicleData.setValue(dictionary["model"], forKey: "model")
                        vehicleData.setValue(dictionary["series"], forKey: "series")
                        vehicleData.setValue(dictionary["variant"], forKey: "variant")
                        vehicleData.setValue(dictionary["type"], forKey: "type")
                        vehicleData.setValue(dictionary["yearStart"], forKey: "yearStart")
                        vehicleData.setValue(dictionary["yearEnd"], forKey: "yearEnd")
                        vehicleData.setValue(dictionary["engineSizeLitres"], forKey: "engineSizeLitres")
                        vehicleData.setValue(dictionary["consumptionLitres"], forKey: "consumptionLitres")
                        
                        // We will now add the make to the list, if it is new.
                        addToList(makeToAdd: dictionary["make"] as! String, makeList: &makeList)
                        dynamicId += 1
                    }

                    // We want to add this array to CoreData as a VehicleMakes Object
                    for makeToAdd in makeList
                    {
                        var makeData = VehicleMakes(entity: makeListDesc! , insertInto: managedObjectContex)
                        print(makeToAdd)
                        commitMakeData(make: makeToAdd, makeData: &makeData)
                    }
                    
                    // Finally we will set the file size and the "PreLoaded" flag into the default user
                    // data for next startup!
                    let filesize = try FileManager.default.attributesOfItem(atPath: (JSONFile?.path)!)[FileAttributeKey.size] as! Double
                    
                    // Commit the values here!
                    UserDefaults.standard.setValue(true, forKey: UserKeys.preLoaded.rawValue)
                    UserDefaults.standard.setValue(filesize, forKey: UserKeys.vehicleFileSize.rawValue)
                }
                else
                {
                    print("Invalid File!")
                }
            }
            else{
                print("No file")
            }
            // Save the context here, the parsing is complete!
            try managedObjectContex.save()
        }
        catch{
            print(error.localizedDescription + " AT ROW: " + String(dynamicId))
        }
    }
    
    // Commit a list of makes to the VehicleMake Object
    private func commitMakeData(make: String, makeData: inout VehicleMakes)
    {
        makeData.setValue(make, forKey: "name")
    }
    
    // Validate the user data to ensure we have a user data object at all, and only one
    private func userDataValidate()
    {
        let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData")
        
        let context = persistentContainer.viewContext
        
        let makeListDesc = NSEntityDescription.entity(forEntityName: "UserData", in: context)
        
        do
        {
            let userDataObject = try context.fetch(fetchRequest)
            
            if userDataObject.first == nil {
                
                let userData = UserData(entity: makeListDesc! , insertInto: context)
                userData.setValue(1, forKey: "userID")
                userData.setValue(MyTankConstants.invalidID, forKey: "vehicleID")
                userData.setValue(MyTankConstants.defaultCostPerLitre, forKey: "costPerUnit")
            }
            
            try context.save()
        }
        catch
        {
            
        }
    }
    
    // Add a string to a list, if it dosent already exist and then sort that list
    private func addToList(makeToAdd: String, makeList: inout [String])
    {
        if !makeList.contains(makeToAdd)
        {
            makeList.append(makeToAdd)
        }
    }

    // This function clears the data from a selected entity, given by fetchRequest
    func wipeData(fetchRequest: NSFetchRequest<NSFetchRequestResult>)
    {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        let context = persistentContainer.viewContext
        do{
            try context.execute(deleteRequest)
            UserDefaults.standard.setValue(false, forKey: UserKeys.preLoaded.rawValue)
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Core Data stack
    
    var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
