//
//  ManageCenterVM.swift
//  Swyng
//
//  Created by Dixit Rathod on 04/06/21.
//

import Foundation
import RxCocoa

struct ManageCenterVM {
    var centerData = BehaviorRelay<[String]>(value:["Level up", "Vplayer sports", "4s JP", "Turfan"])
    var sportData = BehaviorRelay<[String]>(value:["Badminton", "Cricket", "Football", "Running", "Squash", "Table Tennis", "Table Tennis", "Table Tennis", "Table Tennis", "Table Tennis"])
    var selectedCenters = BehaviorRelay<[Int]>(value: [])
    var selectedSpors = BehaviorRelay<[Int]>(value: [])
    var tableHeight = BehaviorRelay<CGFloat>(value:0)
    var collectionHeight = BehaviorRelay<CGFloat>(value:0)
    
}
