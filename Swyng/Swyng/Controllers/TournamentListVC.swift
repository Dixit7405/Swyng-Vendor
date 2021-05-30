//
//  TournamentListVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 11/05/21.
//

import UIKit

class TournamentListVC: UIViewController {
    @IBOutlet weak var lblSelectedTab:UILabel!
    @IBOutlet weak var lblNonSelectedTab:UILabel!
    
    var isUpcoming = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//MARK: - ACTION METHODS
extension TournamentListVC{
    @IBAction func btnSwitchTab(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        isUpcoming = !sender.isSelected
        if sender.isSelected{
            lblSelectedTab.text = "Past Tournaments"
            lblNonSelectedTab.text = "Upcomming Tournaments"
        }
        else{
            lblNonSelectedTab.text = "Past Tournaments"
            lblSelectedTab.text = "Upcomming Tournaments"
        }
    }
    
    @IBAction func btnLeftMenuPressed(_ sender:UIButton){
        leftBarPressed()
    }
    
    @IBAction func btnFilterPressed(_ sender:UIButton){
        self.rightBarPressed()
    }
}


//MARK: - TABLEVIEW DELEGATES
extension TournamentListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcommingCourtBookingCell", for: indexPath) as! UpcommingCourtBookingCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:TournamentStatisticsVC = TournamentStatisticsVC.controller()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - SPORTS FILTER DELEGATE
extension TournamentListVC{
    override func didApplyFilter(filter: Filter) {
        print(filter.sport?.id ?? 0)
    }
}
