//
//  AddParticipantVC.swift
//  Swyng
//
//  Created by Dixit Rathod on 23/05/21.
//

import UIKit

class AddParticipantVC: UIViewController {
    @IBOutlet weak var stackParticipant2:UIStackView!
    @IBOutlet weak var lblParticipant1Header:UILabel!
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var nslcCollectionHeight:NSLayoutConstraint!
    enum SelectedTournaments {
        case mens
        case woments
        case mixed
    }
    
    var selected = 0
    var arrCategories:[TournamentsType] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.addObserver(self, forKeyPath: #keyPath(UICollectionView.contentSize), options: .new, context: nil)
        // Do any additional setup after loading the view.
    }
    
    

}

//MARK: - COLLECTIONVIEW DELEGATES
extension AddParticipantVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        nslcCollectionHeight.constant = collectionView.contentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionsCell", for: indexPath) as! OptionsCell
        cell.optionView.lblTitle.text = arrCategories[indexPath.item].name
        cell.optionView.selected = indexPath.item == selected
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = indexPath.item
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 32)/2
        return CGSize(width: width, height: 70)
    }
}

//MARK: - API SERVICES
extension AddParticipantVC{
    private func addParticipant(){
        
    }
}
