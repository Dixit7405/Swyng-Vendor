//
//  AccountInfoVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 29/04/21.
//

import UIKit

class AccountInfoVC: UIViewController {
    @IBOutlet weak var txtfFirstName:CustomField!
    @IBOutlet weak var txtfLastName:CustomField!
    @IBOutlet weak var txtfMobile:CustomField!
    @IBOutlet weak var txtfEmail:CustomField!
    @IBOutlet weak var mainStackView:UIStackView!
    
    var cityId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - CUSTOM METHODS
extension AccountInfoVC{
    private func populateData(){
        if let profile = ApplicationManager.profileData{
            txtfFirstName.text = profile.fname
            txtfLastName.text = profile.lname
            txtfEmail.text = profile.email
            txtfMobile.text = profile.mobileNo
        }
    }
}

//MARK: API SERVICES
extension AccountInfoVC{
    private func getProfile(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getProfile, type: CommonResponse<Profile>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<Profile> else {return}
            if let data = self.successBlock(response: response){
                ApplicationManager.profileData = data
                self.populateData()
            }
        }
    }
}
