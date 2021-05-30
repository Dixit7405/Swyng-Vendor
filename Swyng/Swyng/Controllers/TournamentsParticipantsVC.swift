//
//  TournamentsParticipantsVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 12/05/21.
//

import UIKit

class TournamentsParticipantsVC: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var nslcCollectionHeight:NSLayoutConstraint!
    @IBOutlet weak var nslcTableHeight:NSLayoutConstraint!
    
    var arrCategories:[TournamentsType] = []
    enum SelectedTournaments {
        case mens
        case woments
        case mixed
    }
    
    var selected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.addObserver(self, forKeyPath: #keyPath(UICollectionView.contentSize), options: .new, context: nil)
        tableView.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        getTournamentCategories()
        // Do any additional setup after loading the view.
    }
}

//MARK: - COLLECTIONVIEW DELEGATES
extension TournamentsParticipantsVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        nslcCollectionHeight.constant = collectionView.contentSize.height + 32
        nslcTableHeight.constant = tableView.contentSize.height + 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionsCell", for: indexPath) as! OptionsCell
        cell.optionView.lblTitle.text = arrCategories[indexPath.item].name
        cell.optionView.selected = indexPath.item == selected
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = indexPath.item
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 32)/2
        return CGSize(width: width, height: 70)
    }
}

//MARK: - TABLEVIEW DELEGATE
extension TournamentsParticipantsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantCell", for: indexPath) as! ParticipantCell
        
        if indexPath.row == 4{
            cell.viewParticipant2.isHidden = true
            cell.lblParticipant1.textColor = UIColor.white
            cell.viewParticipant1.backgroundColor = UIColor.AppColor.themeColor
            cell.lblIndex.text = ""
            cell.lblParticipant1.text = "Add A Participant"
        }
        else{
            cell.viewParticipant1.backgroundColor = UIColor.white
            cell.viewParticipant2.isHidden = false//selected != .mixed
            cell.lblIndex.text = "\(indexPath.row + 1)"
            cell.lblParticipant1.text = "Andy Roddick"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4{
            let vc:AddParticipantVC = AddParticipantVC.controller()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


//MARK: - API SERVICES
extension TournamentsParticipantsVC{
    private func getTournamentCategories(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .get, endPoint: EndPoints.getTournamentTypes, type: CommonResponse<[TournamentsType]>.self, failer: failureBlock()) { success in
            guard let response = success as? CommonResponse<[TournamentsType]> else {return}
            if let data = self.successBlock(response: response){
                self.arrCategories = data
                self.collectionView.reloadData()
            }
        }
    }
}
