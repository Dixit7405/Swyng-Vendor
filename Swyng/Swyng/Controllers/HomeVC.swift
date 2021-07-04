//
//  HomeVC.swift
//  Swyng
//
//  Created by Dixit Rathod on 05/06/21.
//

import UIKit

class HomeVC: BaseVC {
    @IBOutlet weak var selectedCenterView:OptionView!
    @IBOutlet weak var selectedSportView:OptionView!
    @IBOutlet weak var tblUpcoming:UITableView!
    @IBOutlet weak var nslcTableHeight:NSLayoutConstraint!
    @IBOutlet weak var lblUpcomingHeader:UILabel!
    @IBOutlet weak var selectedSportStack:UIStackView!
    @IBOutlet weak var runsTableView:UITableView!
    @IBOutlet weak var nslcRunsTable:NSLayoutConstraint!
    
    var tournaments:[Tournaments] = []
    var runs:[Run] = []
    var arrCategories:[TournamentsType] = []
    var arrRunsCategories:[RunsCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLeftBarButton()
        tblUpcoming.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        runsTableView.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ApplicationManager.selectedSport == nil || ApplicationManager.selectedCenter == nil{
            let vc:ManageCenterVC = .controller()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            return
        }
        
        selectedSportStack.arrangedSubviews.forEach({$0.removeFromSuperview()})
        for center in ApplicationManager.selectedCenter ?? []{
            let optionView = OptionView()
            optionView.lblTitle.text = center.centerTitle
            selectedSportStack.addArrangedSubview(optionView)
            optionView.snp.makeConstraints({
                $0.height.equalTo(50)
                $0.width.equalToSuperview().dividedBy(1.2)
            })
        }
        
        for sport in ApplicationManager.selectedSport ?? []{
            let optionView = OptionView()
            optionView.lblTitle.text = sport.name
            selectedSportStack.addArrangedSubview(optionView)
            optionView.snp.makeConstraints({
                $0.height.equalTo(50)
                $0.width.equalToSuperview().dividedBy(1.5)
            })
        }
        
//        selectedCenterView.lblTitle.text = ApplicationManager.selectedCenter?.centerTitle
//        selectedSportView.lblTitle.text = ApplicationManager.selectedSport?.name
        isTournament ? getTournamentCategories() : getRunsCategories()
        lblUpcomingHeader.text = isTournament ? "Upcoming Tournament" : "Upcoming Runs"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func btnMenuTapped(_ sender:UIBarButtonItem){
        
    }
    
    @IBAction func btnFilterPressed(_ sender:UIBarButtonItem){
        let vc:ManageCenterVC = .controller()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - ACTION METHODS
extension HomeVC{
    
}

//MARK: - TABLEVIEW DELEGATES
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        nslcTableHeight.constant = tblUpcoming.contentSize.height
        nslcRunsTable.constant = runsTableView.contentSize.height
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isTournament{
            return tournaments.count
        }
        else{
            return runs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcommingCourtBookingCell", for: indexPath) as! UpcommingCourtBookingCell
        if isTournament{
            cell.tournamentView.categories = arrCategories
            cell.tournamentView.tournament = tournaments[indexPath.row]
        }
        else{
            cell.tournamentView.runsCategories = arrRunsCategories
            cell.tournamentView.runs = runs[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:TournamentDetailsVC = TournamentDetailsVC.controller()
        
        if isTournament{
            vc.tournament = tournaments[indexPath.row]
            ApplicationManager.tournament = tournaments[indexPath.row]
        }
        else{
            vc.runs = runs[indexPath.row]
            ApplicationManager.runs = runs[indexPath.row]
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - API services
extension HomeVC{
    private func getAllTournaments(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getUpPastTournaments + "upcoming", type: CommonResponse<[Tournaments]>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<[Tournaments]> else {return}
            if let data = self.successBlock(response: response){
                self.tournaments = data
                self.tblUpcoming.reloadData()
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
    
    private func getRunsCategories(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .get, endPoint: EndPoints.getRunsCategory, type: CommonResponse<[RunsCategory]>.self, failer: failureBlock()) { success in
            guard let response = success as? CommonResponse<[RunsCategory]> else {return}
            if let data = self.successBlock(response: response){
                self.arrRunsCategories = data
                self.getUpcomingRuns()
                
                
            }
        }
    }
    
    private func getUpcomingRuns(){
        let endPoint = EndPoints.getUpPastRuns + "upcoming"
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        self.startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: endPoint, type: CommonResponse<[Run]>.self, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            if let response = success as? CommonResponse<[Run]>, let data = self.successBlock(response: response){
                self.runs = data
                self.tblUpcoming.reloadData()
            }
        }
    }
}
