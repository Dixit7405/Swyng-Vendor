//
//  UpcomingTournamentVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 10/05/21.
//

import UIKit

class UpcomingTournamentVC: BaseVC {
    @IBOutlet weak var tableView:UITableView!
    
    var tournaments:[Tournaments] = []
    var arrCategories:[TournamentsType] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if arrCategories.count == 0{
            getTournamentCategories()
        }
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

//MARK: - ACTION METHODS
extension UpcomingTournamentVC{
    @IBAction func filterPressed(_ sender:UIButton){
        rightBarPressed()
    }
    
    @IBAction func btnLeftBar(_ sender:UIButton){
        leftBarPressed()
    }
}

//MARK: - TABLEVIEW DELEGATES
extension UpcomingTournamentVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournaments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcommingCourtBookingCell", for: indexPath) as! UpcommingCourtBookingCell
        
        cell.tournamentView.tournament = tournaments[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:TournamentDetailsVC = TournamentDetailsVC.controller()
        vc.tournament = tournaments[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - FILTER DELEGATE
extension UpcomingTournamentVC{
    override func didApplyFilter(filter: Filter) {
        super.didApplyFilter(filter: filter)
        if filter.gallery == true{
            let vc:TournamentGridVC = .controller()
            tabBarController?.viewControllers?[2].navigationController?.viewControllers = [vc]
        }
    }
}

//MARK: - API SERVICES
extension UpcomingTournamentVC{
    private func getAllTournaments(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getUpPastTournaments + "upcoming", type: CommonResponse<[Tournaments]>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<[Tournaments]> else {return}
            if let data = self.successBlock(response: response){
                self.tournaments = data
                self.tableView.reloadData()
            }
        }
    }
    
    private func getTournamentCategories(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .get, endPoint: EndPoints.getTournamentTypes, type: CommonResponse<[TournamentsType]>.self, failer: failureBlock()) { success in
            guard let response = success as? CommonResponse<[TournamentsType]> else {return}
            if let data = self.successBlock(response: response){
                self.arrCategories = data
                self.getAllTournaments()
            }
        }
    }
}
