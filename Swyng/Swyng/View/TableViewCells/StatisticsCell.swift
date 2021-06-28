//
//  StatisticsCell.swift
//  Swyng
//
//  Created by Dixit Rathod on 28/06/21.
//

import UIKit

class StatisticsCell: UITableViewCell {
    @IBOutlet weak var viewRegistrations:StatisticsView!
    @IBOutlet weak var viewAmount:StatisticsView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
