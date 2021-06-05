//
//  TournamentStatisticsVC.swift
//  Swyng
//
//  Created by Dixit Rathod on 23/05/21.
//

import UIKit

class TournamentStatisticsVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.lblHeader.text = ApplicationManager.sportType == .tournaments ? "Swyng Badminton Open Tournament" : "Swyng WTF Run"
        
        // Do any additional setup after loading the view.
    }
    
    
}
