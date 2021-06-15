//
//  TournamentRegisterVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 11/05/21.
//

import UIKit
import AppInvokeSDK

class TournamentRegisterVC: BaseVC {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var nslcTableHeight:NSLayoutConstraint!
    
    var selectedIndex:[Int] = []
    
    //MARK: Private Properties
    private let appInvoke = AIHandler()
    private var orderId: String = ""
    private var merchantId: String = ""
    private var txnToken: String = ""
    private var amount : String = ""
    private var callBackURL : String = ""
    private var makeSubscriptionPayment : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        // Do any additional setup after loading the view.
    }

}

//MARK: - ACTION METHODS
extension TournamentRegisterVC{
    @IBAction func btnRegisterPressed(_ sender:UIButton){
        /*
         Staging Environment: https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=<order_id>
         Production Environment: https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=<order_id>
         */
        let merchantKey = "KUnc1uCZ&H2tqBVV"
        self.merchantId = "Gybsho71643150937439"
        self.orderId = "321654"
        self.txnToken = "txn"
        self.callBackURL = "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=\(self.orderId)"
        self.amount = "1"
        
        self.appInvoke.openPaytm(merchantId: self.merchantId, orderId: self.orderId, txnToken: self.txnToken, amount: self.amount, callbackUrl:self.callBackURL, delegate: self, environment: AIEnvironment.staging)
    }
}

// MARK: - AIDelegate
extension TournamentRegisterVC: AIDelegate {
    func didFinish(with status: AIPaymentStatus, response: [String : Any]) {
        print("🔶 Paytm Callback Response: ", response)
        let alert = UIAlertController(title: "\(status)", message: String(describing: response), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openPaymentWebVC(_ controller: UIViewController?) {
        if let vc = controller {
            DispatchQueue.main.async {[weak self] in
                self?.present(vc, animated: true, completion: nil)
            }
        }
        self.dismiss(animated: true)
    }
}

//MARK: - TABLEVIEW DELEGATE
extension TournamentRegisterVC:UITableViewDelegate, UITableViewDataSource{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        nslcTableHeight.constant = tableView.contentSize.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TournamentRegisterCell", for: indexPath) as! TournamentRegisterCell
        cell.btnSelection.isSelected = selectedIndex.contains(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex.contains(indexPath.row){
            let index = selectedIndex.firstIndex(where: {$0 == indexPath.row}) ?? 0
            selectedIndex.remove(at: index)
        }
        else{
            selectedIndex.append(indexPath.row)
        }
        tableView.reloadData()
    }
}
