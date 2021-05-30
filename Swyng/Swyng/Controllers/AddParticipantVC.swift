//
//  AddParticipantVC.swift
//  Swyng
//
//  Created by Dixit Rathod on 23/05/21.
//

import UIKit

class AddParticipantVC: UIViewController {
    @IBOutlet weak var btnMensOpen:UIButton!
    @IBOutlet weak var btnWomensOpen:UIButton!
    @IBOutlet weak var btnMixedOpen:UIButton!
    @IBOutlet weak var stackParticipant2:UIStackView!
    @IBOutlet weak var lblParticipant1Header:UILabel!
    enum SelectedTournaments {
        case mens
        case woments
        case mixed
    }
    
    var selected:SelectedTournaments = .mens
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMensOpen(btnMensOpen)
        // Do any additional setup after loading the view.
    }
    
    

}

//MARK: - ACTION METHODS
extension AddParticipantVC{
    @IBAction func btnMensOpen(_ sender:UIButton){
        selected = .mens
        setButtonSelected(btn: sender)
    }
    
    @IBAction func btnWomensOpen(_ sender:UIButton){
        selected = .woments
        setButtonSelected(btn: sender)
    }
    
    @IBAction func btnMixedOpen(_ sender:UIButton){
        selected = .mixed
        setButtonSelected(btn: sender)
    }
    
    @IBAction func btnAddParticipant(_ sender:UIButton){
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - CUSTOM METHODS
extension AddParticipantVC{
    private func setButtonSelected(btn:UIButton){
        btnMensOpen.setSelected(selected: false)
        btnMixedOpen.setSelected(selected: false)
        btnWomensOpen.setSelected(selected: false)
        btn.setSelected(selected: true)
        stackParticipant2.isHidden = btn != btnMixedOpen
        lblParticipant1Header.isHidden = btn != btnMixedOpen
    }
}
