//
//  BullpenViewController.swift
//  PitchingApp
//
//  Created by Blake Dallas on 3/18/21.
//

import UIKit
import SwiftUI
import CoreData


class BullpenViewController: UIViewController, UIGestureRecognizerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{

    
    // MARK: Whats left to work on
    /*
     
     Get the saving of locations and pitch type of a pitch. And somehow have it go into the correct pitcher's relationships in CoreData
     
     */
    
    
    func missDistance(pitch: Pitch) -> Double {
        var distance = 0.0
        
        let unrootedDistance = pow(pitch.intendedxLoc-pitch.actualxLoc,2) + pow(pitch.intendedyLoc - pitch.actualyLoc, 2)
        distance = unrootedDistance.squareRoot()
        return distance
    }
    
    
    
    
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
        typeField.text = pickerData[row]
    }
    
    var pickerView = UIPickerView()
    
    var pickerData: [String] = [String]()
    
    
    var placeholderX = 0.0
    var placeholderY = 0.0
    var intendedX = 0.0
    var intendedY = 0.0
    var actualX = 0.0
    var actualY = 0.0
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
   
    @IBOutlet weak var typeField: UITextField!
    
    
    
    func createTimer(variable: UIView) {
        let timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                timer.fire()
            variable.removeFromSuperview()
        })
        
    }
    
    @objc func fireTimer() {
        //Do Nothing
    }
    
    @objc func touchedScreen(touch: UITapGestureRecognizer) {
        
        
        
        let touchpoint = touch.location(in: self.view)
        let location = UIView(frame: CGRect(x: touchpoint.x, y: touchpoint.y, width: 5, height: 5))
        location.backgroundColor = .blue
        
        //This will print the location of the touch in an (x,y) coordinate pair
        //print(touchpoint)
        
        
        self.view.addSubview(location)
        
        createTimer(variable: location)
        //print(location.center)
        
        placeholderX = Double(touchpoint.x)
        placeholderY = Double(touchpoint.y)
        
        
        
        
    }
    
   
    
    @objc func setLocationCommand(_ sender: UIButton?) {
        intendedX = placeholderX
        intendedY = placeholderY
        
    }
    
    
    
    @objc func throwPitch(_ sender: UIButton?) {
        managedObjectContext.performAndWait {
            actualX = placeholderX
            actualY = placeholderY
            
            guard let pitch = CoreDataManager.shared.createPitch(type: typeField.text ?? "FB", intendedxLoc: intendedX, intendedyLoc: intendedY, actualxLoc: actualX, actualyLoc: actualY) else {return}
            //print("Pitch type: \(pitch.type ?? "FB")")
            //print("intended location: \(pitch.intendedxLoc), \(pitch.intendedyLoc)")
            //print("actual location: \(pitch.actualxLoc), \(pitch.actualyLoc)")
            //print("Miss distance: \(missDistance(pitch: pitch)) pixels")
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let setLocationButton = UIButton(frame: CGRect(x: 165, y: 620, width: 80, height: 50))
        setLocationButton.backgroundColor = .lightGray
        setLocationButton.setTitle("Set Location", for: .normal)
        setLocationButton.titleLabel!.adjustsFontSizeToFitWidth = true
        
        
        let throwPitchButton = UIButton(frame: CGRect(x: 285, y: 620, width: 80, height: 50))
        throwPitchButton.backgroundColor = .lightGray
        throwPitchButton.setTitle("Throw Pitch", for: .normal)
        throwPitchButton.titleLabel!.adjustsFontSizeToFitWidth = true
        
        
        setLocationButton.addTarget(self,action: #selector(self.setLocationCommand),for: .touchUpInside)
        throwPitchButton.addTarget(self, action: #selector(self.throwPitch), for: .touchUpInside)
        
        
        pickerData = ["FB", "CB", "CH", "SL", "2S", "CT", "SP"]
        typeField.inputView = pickerView
        pickerView.dataSource = pickerData as? UIPickerViewDataSource
        
        pickerView.reloadAllComponents()
        
        pickerView.delegate = self
        
        self.view.addSubview(setLocationButton)
        self.view.addSubview(throwPitchButton)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchedScreen(touch:)))
        
        view.addGestureRecognizer(tap)
        
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
