//
//  TournamentGridCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 09/05/21.
//

import UIKit

class TournamentGridCell: UICollectionViewCell {
    @IBOutlet weak var lblCategory:UILabel!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblAddressTime:UILabel!
    @IBOutlet weak var lblOpenFor:UILabel!
    @IBOutlet weak var lblRegisterBefore:UILabel!
    @IBOutlet weak var lblPlayerCount:UILabel!
    @IBOutlet weak var imgTournament:UIImageView!
    
    
    var tournament:Tournaments?{
        didSet{
//            lblCategory.text = ""
            lblName.text = tournament?.eventName
            let startDate = tournament?.dates?.first?.toCustomDate(.withDay) ?? ""
            let startTime = tournament?.eventStartTime ?? ""
            lblAddressTime.text = startDate + " " + (tournament?.venueAddress ?? "")
            lblOpenFor.text = ""
            lblRegisterBefore.text = "Register before \(tournament?.registerBeforeFromStartTime ?? "") of \(startDate) at \(startTime)"
            lblPlayerCount.text = "\(tournament?.noOfPlayers ?? 0) players have registerd"
        }
    }
    
    var runs:Run?{
        didSet{
//            lblCategory.text = ""
            lblName.text = runs?.runName
            let startDate = runs?.dates?.first?.toCustomDate(.withDay) ?? ""
            let startTime = runs?.eventStartTime ?? ""
            lblAddressTime.text = startDate + " " + (runs?.venueAddress ?? "")
            lblOpenFor.text = ""
            lblRegisterBefore.text = "Register before \(runs?.registerBeforeFromStartTime ?? "") of \(startDate) at \(startTime)"
            lblPlayerCount.text = "\(0) players have registerd"
        }
    }
}
