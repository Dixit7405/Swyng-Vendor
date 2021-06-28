//
//  TournamentStatisticsVC.swift
//  Swyng
//
//  Created by Dixit Rathod on 23/05/21.
//

import UIKit

class TournamentStatisticsVC: BaseVC {
    @IBOutlet weak var tableView:UITableView!
    
    
    var statisticsData:Statistics?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isTournament ? getTournamentCounts() : getRunsCounts()
        
//        headerView.lblHeader.text = sportType == .tournaments ? ApplicationManager.tournament?.tournamentName : ApplicationManager.runs?.runName
        
        // Do any additional setup after loading the view.
    }
    
    
}

//MARK: - TABLEVIEW DELEGATE
extension TournamentStatisticsVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (statisticsData?.category?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticsCell") as! StatisticsCell
        if indexPath.row == 0{
            cell.viewRegistrations.lblTitle.text = "Total Registrations"
            let totalRegister = statisticsData?.totalRegistration ?? 0
            let register = statisticsData?.completedRegistration ?? 0
            cell.viewRegistrations.lblValue.text = String(format: "%d/%d", register,totalRegister)
            
            cell.viewAmount.lblTitle.text = "Total Amount"
            cell.viewAmount.lblValue.text = String(format: "Rs. %d", statisticsData?.totalAmount ?? 0)
        }
        else{
            let category = statisticsData?.category?[indexPath.row-1]
            cell.viewRegistrations.lblTitle.text = category?.categoryName
            let totalRegister = category?.totalTickets ?? 0
            let register = category?.registeredTickets ?? 0
            cell.viewRegistrations.lblValue.text = String(format: "%d/%d", register,totalRegister)
            
            cell.viewAmount.lblTitle.text = "Amount"
            cell.viewAmount.lblValue.text = String(format: "Rs. %d", category?.totalAmount ?? 0)
        }
        return cell
    }
}

//MARK: - API SERVICES
extension TournamentStatisticsVC{
    func getTournamentCounts(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.tournament_id:ApplicationManager.tournament?.tournamentId ?? 0]
        self.startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getRegisterCount, type: CommonResponse<Statistics>.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<Statistics> else {return}
            self.statisticsData = response.data
            self.tableView.reloadData()
        }
    }
    
    func getRunsCounts(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.run_id:ApplicationManager.runs?.id ?? 0]
        self.startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getRunsRegisterCount, type: CommonResponse<Statistics>.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<Statistics> else {return}
            self.statisticsData = response.data
            self.tableView.reloadData()
        }
    }
}
