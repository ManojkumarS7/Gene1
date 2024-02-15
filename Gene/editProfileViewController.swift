//
//  editProfileViewController.swift
//  Gene
//
//  Created by manoj on 14/02/24.
//

import UIKit

class editProfileViewController: UIViewController , UINavigationControllerDelegate & UIImagePickerControllerDelegate {
    
    let user = User(userName: "MR._AX_X", following: 100, followers: 100,  posts: ["image1","image2","image3","image4","image5","image6","image7","image8","image9","image10","image11","image12","image13","image14"])
    
    var imagePicker = UIImagePickerController()
    var imageView = UIImageView()
    
    lazy var ProfileImageView : UIImageView = {
            let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        

             //   imageView.backgroundColor = .init(white: 5, alpha: 5)
                imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "image9")?.resize(targetSize: CGSize(width: 100, height: 100))

                imageView.tintColor = .black
                return imageView
            
    }()
    
    lazy var profileSetButton : UIButton = {
   
                let ProfileSetButton = UIButton()
                ProfileSetButton.setImage(UIImage(systemName: "camera"), for: .normal)
        ProfileSetButton.tintColor = .black
                ProfileSetButton.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
                ProfileSetButton.translatesAutoresizingMaskIntoConstraints = false
               return ProfileSetButton
        
        
    }()
    
    
    lazy var NameLabel : UILabel =  {
        
        let label = UILabel()
        label.text = "Name:"
        label.textColor = .black
        return label
    }()
    
    
    lazy var nameTextField: underlineText = {
        let textField = underlineText()
        textField.text = user.userName
        textField.isUserInteractionEnabled = true
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    
    lazy var phnLabel : UILabel =  {
        
        let label = UILabel()
        label.text = "Phone no:"
        label.textColor = .black
        return label
    }()
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(ProfileImageView)
        view.addSubview(profileSetButton)
        view.addSubview(NameLabel)
        view.addSubview(nameTextField)
        view.addSubview(phnLabel)
        view.backgroundColor = .white


        
        ProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileSetButton.translatesAutoresizingMaskIntoConstraints = false
        NameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        phnLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            ProfileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ProfileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            ProfileImageView.heightAnchor.constraint(equalToConstant: 100),
            ProfileImageView.widthAnchor.constraint(equalToConstant: 100),
            
            profileSetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileSetButton.topAnchor.constraint(equalTo: ProfileImageView.bottomAnchor, constant: 5),
            
            NameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            NameLabel.topAnchor.constraint(equalTo: profileSetButton.bottomAnchor, constant: 50),
            
            phnLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            phnLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 50),
        
            
            nameTextField.leadingAnchor.constraint(equalTo: NameLabel.trailingAnchor, constant: 10),
                nameTextField.centerYAnchor.constraint(equalTo: NameLabel.centerYAnchor),
                nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        
        ])
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    @objc func profileImageTapped() {
        presentImagePicker()
    }
    
    func presentImagePicker() {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    
        present(imagePicker, animated: true, completion: nil)


    }

   

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
          //  imageView.image = selectedImage
            
            ProfileImageView.image = selectedImage
            
           
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }


}
