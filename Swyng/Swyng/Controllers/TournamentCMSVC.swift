//
//  TournamentCMSVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 12/05/21.
//

import UIKit
import WebKit
import BSImagePicker
import Photos

class TournamentCMSVC: BaseVC {
    @IBOutlet weak var viewWebContainer:UIView!
    @IBOutlet weak var viewUploadFiles:UIView!
    @IBOutlet weak var lblUploadTime:UILabel!
    @IBOutlet weak var lblUploadType:UILabel!
    @IBOutlet weak var btnUpload:UIButton!
    
    enum PageType {
        case fixture
        case results
        case gallery
        case published
    }
    
    var pageType:PageType = .fixture
    var tournament:Tournaments?{
        get{
            return ApplicationManager.tournament
        }
    }
    
    var runs:Run?{
        get{
            return ApplicationManager.runs
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        var fileString:String?
        let time = (isTournament ? ApplicationManager.tournament?.registerBeforeFromStartTime : ApplicationManager.runs?.registerBeforeFromStartTime) ?? ""
        let name = (isTournament ? ApplicationManager.tournament?.tournamentName : ApplicationManager.runs?.runName) ?? ""
        switch pageType {
        case .fixture:
            headerView.lblHeader.text = "\(name) Fixtures & Schedule"
            lblUploadTime.text = """
                                Please upload the fixtures & schedule by
                                \(time).
                                Thank you!
                                """
            lblUploadType.text = "Upload A PDF Document Only"
            btnUpload.setTitle("Upload Fixtures & Schedule", for: .normal)
            fileString = isTournament ? tournament?.fixerAndSchedulePdf : runs?.fixerAndSchedulePdf
        case .results:
            headerView.lblHeader.text = "\(name) Results"
            lblUploadTime.text = """
                                Please upload the results by
                                \(time).
                                Thank you!
                                """
            lblUploadType.text = "Upload A PDF Document Only"
            btnUpload.setTitle("Upload Results", for: .normal)
            fileString = isTournament ? tournament?.tournamentResult : runs?.runResult
        case .gallery:
            headerView.lblHeader.text = "\(name) Photo Gallery"
            lblUploadTime.text = ""
            lblUploadType.text = "Upload .png or .jpeg images Only"
            btnUpload.setTitle("Upload Photos", for: .normal)
            fileString = isTournament ? tournament?.galleryImage : runs?.galleryImage
        case .published:
            headerView.lblHeader.text = "\(name) Published"
            lblUploadTime.text = """
                                Please upload the published by
                                \(time).
                                Thank you!
                                """
            lblUploadType.text = "Upload A PDF Document Only"
            btnUpload.setTitle("Upload Results", for: .normal)
            fileString = isTournament ? tournament?.tournamentPublished : runs?.runPublished
        }
        /*if let fileString = fileString{
            viewUploadFiles.isHidden = true
            viewWebContainer.isHidden = false
            if pageType == .gallery{
                let imageView = UIImageView()
                viewWebContainer.addSubview(imageView)
                imageView.snp.makeConstraints({
                    $0.edges.equalToSuperview()
                })
                imageView.setImage(from: fileString)
                return
            }
            let webView = WKWebView()
            viewWebContainer.addSubview(webView)
            webView.snp.makeConstraints({
                $0.edges.equalToSuperview()
            })
            if let url = URL(string: fileString){
                webView.load(URLRequest(url: url))
            }
        }*/
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnUploadPressed(_ sender:UIButton){
        if pageType == .gallery{
            uploadImages()
        }
        else{
            self.openPDFPicker(vc: self)
        }
    }
    
    private func uploadImages(){
        let imagePicker = ImagePickerController()

        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
        }, finish: { (assets) in
            var data:[Data] = []
            for asset in assets{
                PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: nil) { (image, info) in
                    // Do something with image
                    if let imageData = image?.jpegData(compressionQuality: 0.5){
                        data.append(imageData)
                    }
                    if data.count == assets.count{
                        if self.isTournament{
                            self.uploadGalleryImages(data: data)
                        }
                        else{
                            self.uploadRunsGalleryImages(data: data)
                        }
                    }
                }
                
            }
            // User finished selection assets.
        })
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
                    if self.isTournament{
                        uploadPDFFiles(data: data)
                    }
                    else{
                        uploadRunsFile(data: data)
                    }
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
        var params:[String:Any] = [Parameters.id:ApplicationManager.tournament?.tournamentId ?? 0]
        var endPoint = ""
        if pageType == .fixture{
            params[Parameters.fixerAndSchedulePdf] = data
            endPoint = EndPoints.uploadTournamentFixture
        }
        else if pageType == .results{
            params[Parameters.tournamentResult] = data
            endPoint = EndPoints.uploadTournamentResult
        }
        else if pageType == .published{
            params[Parameters.tournamentPublished] = data
            endPoint = EndPoints.uploadTournamentPublished
        }
        Webservices().upload(with: params, method: .post, endPoint: endPoint, type: CommonResponse<Tournaments>.self, mimeType:.pdf, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            self.stopActivityIndicator()
            guard let response = success as? CommonResponse<Tournaments> else {return}
            self.showAlertWith(message: response.message ?? "")
        }
    }
    
    private func uploadRunsFile(data:Data){
        var params:[String:Any] = [Parameters.id:ApplicationManager.runs?.id ?? 0]
        var endPoint = ""
        if pageType == .fixture{
            params[Parameters.fixerAndSchedulePdf] = data
            endPoint = EndPoints.createRunSchedule
        }
        else if pageType == .results{
            params[Parameters.runResult] = data
            endPoint = EndPoints.uploadRunResult
        }
        else if pageType == .published{
            params[Parameters.runPublished] = data
            endPoint = EndPoints.uploadRunsPublished
        }
        Webservices().upload(with: params, method: .post, endPoint: endPoint, type: CommonResponse<Run>.self, mimeType:.pdf, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            self.stopActivityIndicator()
            guard let response = success as? CommonResponse<Run> else {return}
            self.showAlertWith(message: response.message ?? "")
        }
    }
    
    private func uploadGalleryImages(data:[Data]){
        let params:[String:Any] = [Parameters.id:ApplicationManager.tournament?.tournamentId ?? 0,
                                   Parameters.gallery:data]
        startActivityIndicator()
        Webservices().upload(with: params, method: .post, endPoint: EndPoints.uploadTournamentGallery, type: CommonResponse<[TournamentGallery]>.self, mimeType: .image, showProgress: false, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<[TournamentGallery]> else {return}
            self.showAlertWith(message: response.message ?? "Images uploaded successfully", okPressed: {
                let vc:TournamentGalleryVC = .controller()
                navigationController?.pushViewController(vc, animated: true)
            }){
                print("cancel")
            }
        }
    }
    
    private func uploadRunsGalleryImages(data:[Data]){
        let params:[String:Any] = [Parameters.id:ApplicationManager.runs?.id ?? 0,
                                   Parameters.runPublished:data]
        startActivityIndicator()
        Webservices().upload(with: params, method: .post, endPoint: EndPoints.uploadRunsGallery, type: CommonResponse<[TournamentGallery]>.self, mimeType: .image, showProgress: false, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<[TournamentGallery]> else {return}
            self.showAlertWith(message: response.message ?? "Images uploaded successfully", okPressed: {
                let vc:TournamentGalleryVC = .controller()
                navigationController?.pushViewController(vc, animated: true)
            }){
                print("cancel")
            }
        }
    }
}
