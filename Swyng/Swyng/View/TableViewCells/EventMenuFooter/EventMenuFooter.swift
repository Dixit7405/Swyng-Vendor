//
//  EventMenuFooter.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 28/04/21.
//

import UIKit

class EventMenuFooter: UICollectionReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btnLogoutPressed(_ sender:UIButton){
        ApplicationManager.authToken = nil
        ApplicationManager.profileData = nil
        AppUtilities.setRootController()
    }
    
}
