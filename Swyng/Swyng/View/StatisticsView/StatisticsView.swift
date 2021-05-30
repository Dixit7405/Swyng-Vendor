//
//  StatisticsView.swift
//  Swyng
//
//  Created by Dixit Rathod on 22/05/21.
//

import Foundation
import UIKit

class StatisticsView:UIView{
    @IBOutlet var view:UIView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblValue:UILabel!
    
    @IBInspectable var title:String?{
        didSet{
            setupData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setupData(){
        lblTitle.text = title
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed(String(describing: StatisticsView.self), owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
        
    }
}
