//
//  HeaderView.swift
//  Swyng
//
//  Created by Dixit Rathod on 05/06/21.
//

import UIKit

class HeaderView: UIView {
    @IBOutlet var view:UIView!
    @IBOutlet weak var imgHeader:UIImageView!
    @IBOutlet weak var lblHeader:UILabel!
    @IBOutlet weak var btnBack:UIButton!
    @IBOutlet weak var btnMenu:UIButton!
    
    typealias ButtonsBlock = (()->Void)
    var menuBlock:ButtonsBlock?
    var backBlock:ButtonsBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
        setupPageData()
    }
    
    @IBAction func btnMenuPressed(_ sender:UIButton){
        if let block = menuBlock{
            block()
        }
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        if let block = backBlock{
            block()
        }
    }
    
    private func setupPageData(){
        imgHeader.image = ApplicationManager.sportType == .tournaments ? #imageLiteral(resourceName: "6") : #imageLiteral(resourceName: "runs")
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed(String(describing: HeaderView.self), owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
    }
}
