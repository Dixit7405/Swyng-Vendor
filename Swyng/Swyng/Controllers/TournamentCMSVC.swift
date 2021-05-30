//
//  TournamentCMSVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 12/05/21.
//

import UIKit
import WebKit

class TournamentCMSVC: UIViewController {
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var viewWebContainer:UIView!
    @IBOutlet weak var viewUploadFiles:UIView!
    @IBOutlet weak var lblUploadTime:UILabel!
    @IBOutlet weak var lblUploadType:UILabel!
    @IBOutlet weak var btnUpload:UIButton!
    
    enum PageType {
        case fixture
        case results
        case gallery
    }
    
    var pageType:PageType = .fixture
    var tournament:Tournaments?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        switch pageType {
        case .fixture:
            lblTitle.text = """
                            SWYNG Badminton
                            Open
                            Tournament
                            Fixtures & Schedule
                            """
            lblUploadTime.text = """
                                Please upload the fixtures & schedule by
                                08.00 PM Sat 21 Mar 2020.
                                Thank you!
                                """
            lblUploadType.text = "Upload A PDF Document Only"
            btnUpload.setTitle("Upload Fixtures & Schedule", for: .normal)
        case .results:
            lblTitle.text = """
                            SWYNG Badminton
                            Open Tournament
                            Results
                            """
            lblUploadTime.text = """
                                Please upload the results by
                                08.00 PM Sat 21 Mar 2020.
                                Thank you!
                                """
            lblUploadType.text = "Upload A PDF Document Only"
            btnUpload.setTitle("Upload Results", for: .normal)
        case .gallery:
            lblTitle.text = """
                            SWYNG Badminton
                            Open Tournament
                            Photo Gallery
                            """
            lblUploadTime.text = ""
            lblUploadType.text = "Upload .png or .jpeg images Only"
            btnUpload.setTitle("Upload Photos", for: .normal)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnUploadPressed(_ sender:UIButton){
        if pageType == .gallery{
            self.showMediaPickerOptions(vc: self)
        }
        else{
            self.openPDFPicker(vc: self)
        }
    }
}

//MARK: - Image Picker Delegate
extension TournamentCMSVC:UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) { [unowned self] in
            let vc:TournamentGalleryVC = TournamentGalleryVC.controller()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - PDF Picker Delegate
extension TournamentCMSVC: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        viewUploadFiles.isHidden = true
        viewWebContainer.isHidden = false
        let webView = WKWebView()
        viewWebContainer.addSubview(webView)
        webView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        if let url = urls.first{
            webView.load(URLRequest(url: url))
            do{
                if let data = try? Data(contentsOf: url){
                    uploadPDFFiles(data: data)
                }
                
            }
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

//MARK: - API SERVICES
extension TournamentCMSVC{
    private func uploadPDFFiles(data:Data){
        startActivityIndicator()
        var params:[String:Any] = [Parameters.id:tournament?.tournamentId ?? 10]
        var endPoint = ""
        if pageType == .fixture{
            params[Parameters.fixerAndSchedulePdf] = data
            endPoint = EndPoints.uploadTournamentFixture
        }
        else if pageType == .results{
            params[Parameters.tournamentResult] = data
            endPoint = EndPoints.uploadTournamentResult
        }
        Webservices().upload(with: params, method: .post, endPoint: endPoint, type: CommonResponse<Tournaments>.self, mimeType:.pdf, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            self.stopActivityIndicator()
            guard let response = success as? CommonResponse<Tournaments> else {return}
            self.showAlertWith(message: response.message ?? "")
        }
    }
}
