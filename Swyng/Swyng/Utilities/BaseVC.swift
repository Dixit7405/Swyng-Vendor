//
//  BaseVC.swift
//  Swyng
//
//  Created by Dixit Rathod on 05/06/21.
//

import Foundation
import UIKit

class BaseVC:UIViewController{
    
    @IBOutlet weak var headerView:HeaderView!
    
    var sportType:SportType{
        get{
            return ApplicationManager.sportType ?? .tournaments
        }
    }
    
    var isTournament:Bool{
        get{
            return ApplicationManager.sportType == .tournaments
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if headerView != nil{
            headerView.backBlock = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            headerView.menuBlock = { [weak self] in
                self?.btnMenuPressed(self?.headerView.btnMenu ?? UIButton())
            }
        }
    }
    
    @IBAction func btnCallPressed(_ sender:UIButton){
        if let url = URL(string: "tel://+919108475471"){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func btnEmailPressed(_ sender:UIButton){
        if let url = URL(string: "mailto:hello@swyng.in"){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func btnWhatsappPressed(_ sender:UIButton){
        let phoneNumber =  "+919108475471" // you need to change this number
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        } else {
            self.showAlertWith(message: "Whatsapp is not installed.")
        }

    }
    
}
