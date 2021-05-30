//
//  TournamentListView.swift
//  Swyng
//
//  Created by Dixit Rathod on 22/05/21.
//

import Foundation
import UIKit

class TournamentListView:UIView{
    @IBOutlet var view:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed(String(describing: TournamentListView.self), owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
    }
}
