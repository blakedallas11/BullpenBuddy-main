//
//  ReturningPlayerViewController.swift
//  PitchingApp
//
//  Created by Blake Dallas on 3/18/21.
//

import UIKit
import CoreData
import SwiftUI


class ReturningPlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     return pickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        playerSelector.text = pickerData[row]
    }
    

    @Environment(\.managedObjectContext) var managedObjectContext
    
    @IBOutlet weak var playerSelector: UITextField!

    var pickerView = UIPickerView()
    
    var pickerData: [String] = [String]()
    var playerList: [Player] = [Player]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        playerList = CoreDataManager.shared.fetchPlayers()!
        
        for player in playerList {
            pickerData.append(player.name!)
            }
        
        playerSelector.inputView = pickerView
        pickerView.dataSource = pickerData as? UIPickerViewDataSource
        
        pickerView.reloadAllComponents()
        
        pickerView.delegate = self
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
