//
//  photoPreviewViewController.swift
//  Gene
//
//  Created by manoj on 06/01/24.
//
import UIKit
import Photos

class photoPreviewViewController : UIView {
    let imageView = UIImageView()
    let saveButton = UIButton()
    let uploadButton = UIButton()
    let retakeButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        addSubview(saveButton)
        
        uploadButton.setTitle("Upload", for: .normal)
        uploadButton.setTitleColor(.black, for: .normal)
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        addSubview(uploadButton)
        
        retakeButton.setTitle("Retake", for: .normal)
        retakeButton.addTarget(self, action: #selector(retakeButtonTapped), for: .touchUpInside)
        addSubview(retakeButton)
        
        // Add constraints
        // Assuming you want buttons at the bottom of the view and imageView to take the remaining space
        imageView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        retakeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            saveButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            uploadButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            uploadButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            uploadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            retakeButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            retakeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            retakeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    @objc func saveButtonTapped() {
        
        guard let imageToSave = imageView.image else {
              print("No image to save.")
              return
          }

          PHPhotoLibrary.requestAuthorization { status in
              guard status == .authorized else {
                  print("Photo library access not authorized.")
                  return
              }

              PHPhotoLibrary.shared().performChanges {
                  PHAssetChangeRequest.creationRequestForAsset(from: imageToSave)
              } completionHandler: { success, error in
                  if let error = error {
                      print("Error saving photo to library: \(error)")
                  } else {
                      print("Photo saved to library successfully.")
                  }
              }
          }
        
    }
    
    @objc func uploadButtonTapped() {
        
        let upload = cameraViewController()
        
        guard let image = imageView.image else {
            print("No image to upload")
            return
        }
        upload.uploadImage(image: image)
    }
    
    @objc func retakeButtonTapped() {
        // Implement retaking action
    }
}


