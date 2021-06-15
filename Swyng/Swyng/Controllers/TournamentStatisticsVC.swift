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
        
        headerView.lblHeader.text = sportType == .tournaments ? ApplicationManager.tournament?.tournamentName : ApplicationManager.runs?.runName
        
        // Do any additional setup after loading the view.
    }
    
    
}
