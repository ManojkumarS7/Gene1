//
//  photoPreviewViewController.swift
//  Gene
//
//  Created by manoj on 06/01/24.
//

import Foundation
import UIKit

class photoPreviewViewController: UIViewController {
    
    var imageToDisplay: UIImage?
    var delegate: photoPreviewDelegate?
    var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//    //    let imageName = "launch logo 1024"
//        let image = UIImage(named: imageToDisplay)
//        
//        let imageView = UIImageView(image: image!)
//        imageView.contentMode = .scaleAspectFit
//        imageView.frame = view.bounds
//        view.addSubview(imageView)
//        
        let saveButon = UIButton(type: .system)
        saveButon.setTitle("Save", for: .normal)
        saveButon.setTitleColor(.white, for: .normal)
        saveButon.addTarget(self, action: #selector(savePhotoOnGallery), for: .touchUpInside )
        saveButon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButon)
        
        
        let uploadButton = UIButton(type: .system)
        uploadButton.setTitle("Upload", for: .normal)
        uploadButton.setTitleColor(.white, for: .normal)
        uploadButton.addTarget(self, action: #selector(uploadButtonPressed), for: .touchUpInside)
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(uploadButton)
        
        let backButton = UIButton(type: .system)
        backButton.setTitle("", for: .normal)
     //   backButton.addTarget(self, action: #selector (backButtonTapped()), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
        
            saveButon.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButon.trailingAnchor.constraint(equalTo: uploadButton.leadingAnchor, constant: -20),
            saveButon.heightAnchor.constraint(equalToConstant: 44),
        
            
        ])
        
        NSLayoutConstraint.activate([
        
            uploadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            uploadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            uploadButton.widthAnchor.constraint(equalTo: saveButon.widthAnchor),
            uploadButton.heightAnchor.constraint(equalToConstant: 44)

        
        
        ])
        
        
        statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textAlignment = .center
        statusLabel.textColor = .white
        statusLabel.backgroundColor = UIColor(white: 0, alpha: 0.7)
        statusLabel.layer.cornerRadius = 10
        statusLabel.clipsToBounds = true
        view.addSubview(statusLabel)
        
        
        NSLayoutConstraint.activate([
        
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statusLabel.widthAnchor.constraint(equalToConstant: 150),
            statusLabel.heightAnchor.constraint(equalToConstant: 30)
        
        
        
        ])
      
        
    }
    


    
    @objc func savePhotoOnGallery() {
        
        
            
         
            showStatus("Saved!", duration: 0.5)
        
    }
    
    @objc func uploadButtonPressed() {
        
        showStatus("Uploading...", duration: 0.5)
    }
    @objc func backButtonTapped() {
        
        dismiss(animated: true, completion: nil)
    }
    
    func showStatus(_ message: String, duration: TimeInterval) {
        
        statusLabel.text = message
        statusLabel.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now()  + duration) {
            self.statusLabel.isHidden = true
        }
    }
}


protocol photoPreviewDelegate: AnyObject {
    func photoPreviewDidSave(_ image: UIImage)
}
