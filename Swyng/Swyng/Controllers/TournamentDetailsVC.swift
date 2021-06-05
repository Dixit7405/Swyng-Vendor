//
//  TournamentDetailsVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 10/05/21.
//

import UIKit

class TournamentDetailsVC: BaseVC {
    @IBOutlet weak var lblAbout:UILabel!
    @IBOutlet weak var lblDateTime:UILabel!
    @IBOutlet weak var lblRegisterBefore:UILabel!
    @IBOutlet weak var lblVenue:UILabel!
    @IBOutlet weak var lblParticipationFees:UILabel!
    @IBOutlet weak var lblRewards:UILabel!
    @IBOutlet weak var lblTournamentsInfo:UILabel!
    @IBOutlet weak var lblPleaseNote:UILabel!
    @IBOutlet weak var lblFAQ:UILabel!
    @IBOutlet weak var lblTerms:UILabel!
    @IBOutlet weak var lblAboutOrganization:UILabel!
    @IBOutlet weak var lblPastUpcomingEventsFrom:UILabel!
    @IBOutlet weak var lblAboutOrganizationHeader:UILabel!
    @IBOutlet weak var lblEventsFromHeader:UILabel!
    
    var tournament:Tournaments?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        // Do any additional setup after loading the view.
    }
    
}

//MARK: - CUSTOM FUNCTIONS
extension TournamentDetailsVC{
    private func setupData(){
        lblAbout.text = tournament?.aboutTournament
        let startDate = tournament?.dates?.first?.convertDate(format: "yyyy-MM-dd").toDate(format: "EEEE dd MMM yyyy") ?? ""
        let startTime = tournament?.eventStartTime ?? ""
        let reportTime = tournament?.reportingTime ?? ""
        lblDateTime.text = startDate + " " + startTime + "\n" + reportTime
        lblRegisterBefore.text = tournament?.registerBeforeFromStartTime
        lblVenue.text = (tournament?.venueAddress ?? "") + (tournament?.venue ?? "")
        lblParticipationFees.text = tournament?.participationFee
        lblRewards.text = tournament?.rewards
        lblTournamentsInfo.text = tournament?.tournamentInformation
        lblPleaseNote.text = tournament?.pleaseNote
        lblFAQ.text = tournament?.frequentlyAskedQuestion
        lblTerms.text = tournament?.termsAndCondition
        lblAboutOrganization.text = tournament?.aboutOrganizer
//        lblPastUpcomingEventsFrom.text = tournament.
        lblAboutOrganizationHeader.text = "About " + (tournament?.organizer ?? "")
        lblEventsFromHeader.text = "Past/Upcomming events from " + (tournament?.organizer ?? "")
    }
}

//MARK: - ACTION METHODS
extension TournamentDetailsVC{
    
    @IBAction func btnRegisterPressed(_ sender:UIButton){
        let vc:TournamentRegisterVC = TournamentRegisterVC.controller()
        navigationController?.pushViewController(vc, animated: true)
    }
}
