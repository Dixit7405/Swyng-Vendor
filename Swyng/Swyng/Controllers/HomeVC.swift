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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLeftBarButton()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ApplicationManager.sportType == nil{
            let vc:ManageCenterVC = .controller()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            return
        }
        selectedCenterView.lblTitle.text = ApplicationManager.selectedCenter?.centerTitle
        selectedSportView.lblTitle.text = ApplicationManager.selectedSport?.name
    }
    
    @IBAction func btnMenuTapped(_ sender:UIBarButtonItem){
        
    }
    
    @IBAction func btnFilterPressed(_ sender:UIBarButtonItem){
        let vc:ManageCenterVC = .controller()
        navigationController?.pushViewController(vc, animated: true)
    }
}
