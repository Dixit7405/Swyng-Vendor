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
    
}
