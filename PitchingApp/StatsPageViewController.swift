//
//  StatsPageViewController.swift
//  PitchingApp
//
//  Created by Blake Dallas on 3/17/21.
//

import UIKit
import CoreData
import SwiftUI

class StatsPageViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
    
    @IBOutlet weak var StatsTable: UITableView!
    
    var Rows: [[String]] = [[String]]()
    
    
    
    
    func missDistance(pitch: Pitch) -> Double {
        var distance = 0.0
        
        let unrootedDistance = pow(pitch.intendedxLoc-pitch.actualxLoc,2) + pow(pitch.intendedyLoc - pitch.actualyLoc, 2)
        distance = unrootedDistance.squareRoot()
        return distance
    }
    
    
    
    func averageMiss() -> Double {
        var averageMissDistance = 0.0
        let Pitches = CoreDataManager.shared.fetchPitches() ?? []
        var temp = 0.0
        if Pitches.isEmpty {
            return 69.69
        } else {
            for pitch in Pitches {
                temp = temp + missDistance(pitch: pitch)
            }
        }
        averageMissDistance = temp / Double(Pitches.count)
        
        return averageMissDistance
    }
    
    
    
    func averageMissByPitch(type: String) -> Double {
        var averageMissOnPitch = 0.0
        let pitches = CoreDataManager.shared.fetchPitches() ?? []
        var temp = 0.0
        var count = 0
        if pitches.isEmpty {
            return 0.0
        } else {
            for pitch in pitches {
                if pitch.type == type {
                    temp = temp + missDistance(pitch: pitch)
                    count = count + 1
                }
            }
        }
        averageMissOnPitch = temp / Double(count)
        
        return averageMissOnPitch
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rows.count
    }
    
    func tableView(_ tableview: UITableView ,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableview.dequeueReusableCell(withIdentifier: "cell")
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        if cell == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            }
        cell!.textLabel?.text = Rows[indexPath.row][0]
        cell!.detailTextLabel?.text = Rows[indexPath.row][1]
        
        return cell!
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StatsTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        Rows = [["FB", "\(String(format: "%.2f",averageMissByPitch(type: "FB"))) pixels"],["CB", "\(String(format: "%.2f",averageMissByPitch(type: "CB"))) pixels"],["CH","\(String(format: "%.2f",averageMissByPitch(type: "CH"))) pixels"],["SL", "\(String(format: "%.2f",averageMissByPitch(type: "SL"))) pixels"],["2S", "\(String(format: "%.2f",averageMissByPitch(type: "2S"))) pixels"],["CT", "\(String(format: "%.2f",averageMissByPitch(type: "CT"))) pixels"],["SP", "\(String(format: "%.2f",averageMissByPitch(type: "SP"))) pixels"]]
        
        
        StatsTable.delegate = self
        StatsTable.dataSource = self
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
