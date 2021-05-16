//
//  NewPlayerViewController.swift
//  PitchingApp
//
//  Created by Blake Dallas on 3/16/21.
//

import UIKit
import SwiftUI
import CoreData

class NewPlayerViewController: UIViewController, UIPickerViewDelegate {
    
    
    
    // MARK: What is left to work on
    /*
    
    Fixing the picker for the handedness, and level of play.
        - the options do not seem to appear
        - once clicked, the options immediately go away and an error occurs
    Adding the constraints to the text boxes on the page to supress the warnings
     
     */
    
    
    
    
    
   
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var handednessField: UITextField!
    @IBOutlet weak var levelField: UITextField!
    
    
    let handednessPicker = UIPickerView()
    let levelPicker = UIPickerView()
    
    
    
    
    
    
    
    
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    
    let handednessPickerData = [String](arrayLiteral: "Left", "Right")
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return handednessPickerData.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     return handednessPickerData[row]
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        handednessField.text = handednessPickerData[row]
        
    }
    
  
    
    
    
    
   
    @objc func myRightSideBarButtonItemTapped(_ sender: UIButton?) {
       managedObjectContext.performAndWait {
            
            
        guard let createdPlayer = CoreDataManager.shared.createPlayer(name: nameField.text ?? "Balaaka", age: ageField.text!, handedness: handednessField.text ?? "Both", level: levelField.text ?? "Flat") else { return }
        //print(createdPlayer.name ?? "Can't find player")
        
        //This function is used for testing purposes to see if the player objects are persisting
        //listPlayers()
        
        //Used to test the delete method in CoreDataManager, it works as of May 8
        //CoreDataManager.shared.deletePlayer(withName: "Jacob Barney")
        
        //Can be Called to delete all objects currently stored in the Core Data persisting container
        //CoreDataManager.shared.deleteAllPlayers()
       }
    }
        
       
    func listPlayers() {
        let players =  CoreDataManager.shared.fetchPlayers()
        if let newPlayers = players {
            for player in newPlayers {
                print(player.name!)
            }
            
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(myRightSideBarButtonItemTapped(_:)) )
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
