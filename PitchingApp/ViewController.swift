//
//  ViewController.swift
//  PitchingApp
//
//  Created by Blake Dallas on 2/9/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newPlayerButton: UIButton!
    @IBOutlet weak var returningPlayerButton: UIButton!
    @IBOutlet weak var statsPageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //If I need to delete all players in the core data store, I uncomment this and launch the simulator
        //CoreDataManager.shared.deleteAllPlayers()
        
        //If I need to delete all the pitches in the Core Data store again, I uncomment this and launch the simulator
        //CoreDataManager.shared.deleteAllPitches()
    }


}

