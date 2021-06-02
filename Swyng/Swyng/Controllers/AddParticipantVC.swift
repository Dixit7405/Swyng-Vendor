//
//  AddParticipantVC.swift
//  Swyng
//
//  Created by Dixit Rathod on 23/05/21.
//

import UIKit

class AddParticipantVC: UIViewController {
    @IBOutlet weak var stackParticipant2:UIStackView!
    @IBOutlet weak var lblParticipant1Header:UILabel!
    @IBOutlet weak var stackParticipant1:UIStackView!
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var nslcCollectionHeight:NSLayoutConstraint!
    @IBOutlet weak var txtfFname1:CustomField!
    @IBOutlet weak var txtfFname2:CustomField!
    @IBOutlet weak var txtfLname1:CustomField!
    @IBOutlet weak var txtfLname2:CustomField!
    @IBOutlet weak var txtfEmail1:CustomField!
    @IBOutlet weak var txtfEmail2:CustomField!
    @IBOutlet weak var txtfMobile1:CustomField!
    @IBOutlet weak var txtfMobile2:CustomField!
    
    
    
    enum SelectedTournaments {
        case mens
        case woments
        case mixed
    }
    var tournamentId = 9
    
    var selected = 0
    var arrCategories:[TournamentsType] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.addObserver(self, forKeyPath: #keyPath(UICollectionView.contentSize), options: .new, context: nil)
        // Do any additional setup after loading the view.
    }
    
    

}

//MARK: - ACTION METHODS
extension AddParticipantVC{
    @IBAction func btnAddParticipant(_ sender:UIButton){
        if isValidFields(isSingle: true){
            addParticipant(forSingle: true)
        }
    }
    
    func isValidFields(isSingle:Bool = true) -> Bool{
        let valid1 = validateStack(stack: stackParticipant1)
        var valid2 = true
        if !isSingle{
            valid2 = validateStack(stack: stackParticipant2)
        }
        return isSingle ? valid1 : (valid1 && valid2)
    }
    
    func validateStack(stack:UIStackView)-> Bool{
        var valid = true
        loop1:for views in stack.arrangedSubviews{
            if let stack = views as? UIStackView{
                loop2:for view in stack.arrangedSubviews{
                    if let txtf = view as? CustomField{
                        if !txtf.checkValidation(){
                            valid = false
                        }
                    }
                }
            }
        }
        return valid
    }
}

//MARK: - COLLECTIONVIEW DELEGATES
extension AddParticipantVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        nslcCollectionHeight.constant = collectionView.contentSize.height
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

//MARK: - API SERVICES
extension AddParticipantVC{
    private func addParticipant(forSingle:Bool = true){
        startActivityIndicator()
        var params:[String:Any] = [Parameters.fname:txtfFname1.text!,
                                   Parameters.lname:txtfLname1.text!,
                                   Parameters.email:txtfEmail1.text!,
                                   Parameters.mobileNo:txtfMobile1.text!,
                                   Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.tournamentCategoryId:arrCategories[selected].tournamentCategoryId ?? 0,
                                   Parameters.id:tournamentId]
        if !forSingle{
            params[Parameters.fname1] = txtfFname2.text!
            params[Parameters.lname1] = txtfLname2.text!
            params[Parameters.email1] = txtfEmail2.text!
            params[Parameters.mobileNo1] = txtfMobile2.text!
        }
        Webservices().request(with: params, method: .post, endPoint: EndPoints.addPartipant, type: CommonResponse<Participants>.self, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            if let response = success as? CommonResponse<Participants>, let _ = self.successBlock(response: response){
                self.showAlertWith(message: response.message ?? "", okPressed: {
                    self.navigationController?.popViewController(animated: true)
                }, cancelPressed: {
                    
                })
            }
        }
    }
}
