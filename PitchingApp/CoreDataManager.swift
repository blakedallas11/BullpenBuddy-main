//
//  CoreDataManager.swift
//  PitchingApp
//
//  Created by Blake Dallas on 4/3/21.
//

import Foundation
import CoreData
import SwiftUI

struct CoreDataManager {
    
    
    
    // MARK: What is left to work on
    /*
     
     Add functions for deletion of a pitch and player
     Add function for fetching pitches of a player
     
     */
    
    
    
    
    
    
    
    
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PitchingApp2")
        container.loadPersistentStores { (completionHandler: NSPersistentStoreDescription, error) in
            if let error = error{
            fatalError("Loading of store failed \(error)")
            }
        }
        return container
    }()
    
    
    
    @discardableResult
    func createPlayer(name: String, age: String, handedness: String, level: String) -> Player? {
        let context = persistentContainer.viewContext
        let player = NSEntityDescription.insertNewObject(forEntityName: "Player", into: context) as! Player
        
        player.name = name
        player.age = age
        player.handedness = handedness
        player.level = level
        
        do {
            try context.save()
            return player
        } catch let createError {
            print("Failed to create: \(createError)")
        }
        
        return nil
    }
    
    
    @discardableResult
    func createPitch(type: String, intendedxLoc: Double, intendedyLoc: Double, actualxLoc: Double, actualyLoc: Double)-> Pitch?{
        let context = persistentContainer.viewContext
        let Pitch = NSEntityDescription.insertNewObject(forEntityName: "Pitch", into: context) as! Pitch
        
        Pitch.type = type
        Pitch.intendedxLoc = intendedxLoc
        Pitch.intendedyLoc = intendedyLoc
        Pitch.actualxLoc = actualxLoc
        Pitch.actualyLoc = actualyLoc
        
        do {
            try context.save()
            return Pitch
        } catch let createError {
            print("Well that didn't work! \(createError)")
        }
        
        return Pitch
    }
    
  
    
    func fetchPlayers() -> [Player]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        
        do{
            let players = try context.fetch(fetchRequest)
            return players
        } catch let fetchError {
            print("Failed to fetch players: \(fetchError)")
        }
        return nil
    }
    
    func fetchPlayer(withName name: String) -> Player? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let players = try context.fetch(fetchRequest)
            return players.first
        }catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }
        return nil
    }
    
    
    
    func deletePlayer(withName name: String) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            if let result = try? context.fetch(fetchRequest) {
                for object in result {
                    context.delete(object)
                    print("deleted an object")
                }
            }
        }
    }
    
    
    
    func deleteAllPlayers() {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false

        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject]

            for item in items {
                context.delete(item)
            }

            // Save Changes
            try context.save()

        } catch {
            print("Could not delete all players...")
        }
    }
    
    
    
    func deleteAllPitches() {
        let context = persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pitch")
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false

        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject]

            for item in items {
                context.delete(item)
            }

            // Save Changes
            try context.save()

        } catch {
            print("Could not delete all pitches")
        }
    }
    
    
    
    
    func deletePitch() {
        /*
         This function will be difficult to correctly implement because of the ambiguity of pitches themselves. There is no uniquenesss to a pitch so to delete a pitch you have to delete it by calling its location, intended location, or type. All of which, another pitch could share those attributes
         */
    }
    
    func fetchPitches() -> [Pitch]? {
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Pitch>(entityName: "Pitch")
        
        do{
            let pitches = try context.fetch(fetchRequest)
            return pitches
        } catch let fetchError {
            print("Failed to fetch pitches: \(fetchError)")
        }
        return nil
    }
    
    
    
    
    
    
}






struct CoreDataManager_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
