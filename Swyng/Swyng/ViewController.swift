//
//  ViewController.swift
//  Swyng
//
//  Created by Dixit Rathod on 20/05/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            AppUtilities.setRootController()
        }
    }

}

