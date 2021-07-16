//
//  ManageCenterVC.swift
//  Swyng
//
//  Created by Dixit Rathod on 04/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class ManageCenterVC: BaseVC {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var nslcTableHeight:NSLayoutConstraint!
    @IBOutlet weak var nslcCollectionHeight:NSLayoutConstraint!
    @IBOutlet weak var btnApply:UIButton!
    
    var viewModel = ManageCenterVM()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.layoutIfNeeded()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        viewModel.centerData.bind(to: tableView.rx.items(cellIdentifier: "OptionContainerCell", cellType: OptionContainerCell.self)){index,model,cell in
            cell.optionView.lblTitle.text = model.centerTitle
            cell.optionView.selected = self.viewModel.selectedCenters.value.contains(index)

        }.disposed(by: disposeBag)
        viewModel.sportData.bind(to: collectionView.rx.items(cellIdentifier: "CityCell", cellType: CityCell.self)){ index, model, cell in
            cell.optionView.lblTitle.text = model.name
            cell.optionView.selected = self.viewModel.selectedSpors.value.contains(index)
        }.disposed(by: disposeBag)
        
        viewModel.tableHeight.bind(to: nslcTableHeight.rx.constant).disposed(by: disposeBag)
        viewModel.collectionHeight.bind(to: nslcCollectionHeight.rx.constant).disposed(by: disposeBag)
        
        
        tableView.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        collectionView.addObserver(self, forKeyPath: #keyPath(UICollectionView.contentSize), options: .new, context: nil)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width-32)/2, height: 50)
        flowLayout.minimumInteritemSpacing = CGFloat.zero
        flowLayout.minimumLineSpacing = CGFloat.zero
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
        
        btnApply.rx.tap.subscribe(onNext: {
            
//            guard self.viewModel.selectedSpors.value.count != 0,
//                  self.viewModel.selectedCenters.value.count != 0
//            else {
//                self.viewModel.alertMessage.accept("Please select sport and center")
//                return
//            }
            
            var arrSports:[Sports] = []
            for index in 0..<self.viewModel.sportData.value.count{
                if self.viewModel.selectedSpors.value.contains(index){
                    arrSports.append(self.viewModel.sportData.value[index])
                }
            }
            
            var arrCenters:[SportCenters] = []
            for index in 0..<self.viewModel.centerData.value.count{
                if self.viewModel.selectedCenters.value.contains(index){
                    arrCenters.append(self.viewModel.centerData.value[index])
                }
            }
            
            ApplicationManager.selectedSport = arrSports
            ApplicationManager.selectedCenter = arrCenters
            
            if self.isModal{
                self.dismiss(animated: true, completion: nil)
            }
            else{
                self.navigationController?.popViewController(animated: true)
            }
            
        }).disposed(by: disposeBag)
        
        self.startActivityIndicator()
        viewModel.getSportsList(failure: failureBlock()) {[weak self] response in
            self?.stopActivityIndicator()
        }
        
        self.startActivityIndicator()
        viewModel.getAllSportCenters(failureBlock: failureBlock()) {[weak self] response in
            self?.stopActivityIndicator()
        }
    }

}

//MARK: - OBSERVE VALUE
extension ManageCenterVC{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        viewModel.tableHeight.accept(tableView.contentSize.height + 10)
        viewModel.collectionHeight.accept(collectionView.contentSize.height + 25)
    }
}

//MARK: - TABLEVIEW DELEGATE
extension ManageCenterVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.selectedCenters.value.contains(indexPath.row){
            var myVal = viewModel.selectedCenters.value
            myVal.removeAll(where: {$0 == indexPath.row})
            viewModel.selectedCenters.accept(myVal)
        }
        else{
            viewModel.selectedCenters.accept(viewModel.selectedCenters.value + [indexPath.row])
        }
//        viewModel.selectedCenters.accept([indexPath.row])
        viewModel.centerData.accept(viewModel.centerData.value)
    }
}

//MARK: - COLLECTION DELEGATE
extension ManageCenterVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.selectedSpors.value.contains(indexPath.item){
            var myVal = viewModel.selectedSpors.value
            myVal.removeAll(where: {$0 == indexPath.row})
            viewModel.selectedSpors.accept(myVal)
        }
        else{
            viewModel.selectedSpors.accept(viewModel.selectedSpors.value + [indexPath.item])
        }
//        viewModel.selectedSpors.accept([indexPath.item])
        viewModel.sportData.accept(viewModel.sportData.value)
    }
}
