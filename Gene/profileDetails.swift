//
//  profileDetails.swift
//  Gene
//
//  Created by manoj on 28/12/23.
//

import UIKit

class ProfileDetailsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //    button.backgroundColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5)
    //    label.textColor = .init(red: 1.5, green: 0.5, blue: 0.5, alpha: 0.5)
    
    //  var user: User?
    var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .black
        
        let closeButton = UIButton()
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 20), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        
        
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .black
        view.addSubview(imageView)
      //  let tabGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
      //  imageView.addGestureRecognizer(tabGesture)
        
        let ProfileSetButton = UIButton()
        ProfileSetButton.setImage(UIImage(systemName: "camera"), for: .normal)
        ProfileSetButton.tintColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 20)
        ProfileSetButton.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
        ProfileSetButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ProfileSetButton)
        
        //        profileImageView.contentMode = .scaleAspectFit
        //        profileImageView.clipsToBounds = true
        //        profileImageView.layer.cornerRadius = 50
        //        profileImageView.translatesAutoresizingMaskIntoConstraints = true
        //        view.addSubview(profileImageView)
        
        let profileName = UILabel()
        profileName.text = "Mr.X"
        profileName.font = .systemFont(ofSize: 20)
        profileName.textAlignment = .center
        profileName.textColor = .init(white: 10, alpha: 10)
        profileName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileName)
        
        let postlabel = UILabel()
        postlabel.text = "Post"
        postlabel.font = .systemFont(ofSize: 15)
        postlabel.textAlignment = .center
        postlabel.textColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 20)
        postlabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postlabel)
        
        let postCount = UILabel()
        postCount.text = "7"
        postCount.font = .systemFont(ofSize: 14)
        postCount.textAlignment = .center
        postCount.textColor = .white
        postCount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postCount)
        
        
        let followersLabel = UILabel()
        followersLabel.text = "Followers"
        followersLabel.font  = .systemFont(ofSize: 15)
        followersLabel.textAlignment = .center
        followersLabel.textColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 20)
        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(followersLabel)
        
        let followersCount = UILabel()
        followersCount.text = "44"
        followersCount.font = .systemFont(ofSize: 14)
        followersCount.textAlignment = .center
        followersCount.textColor = .white
        followersCount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(followersCount)
        
        let followingLabel = UILabel()
        followingLabel.text = "Following"
        followingLabel.font = .systemFont(ofSize: 15)
        followingLabel.textAlignment = .center
        followingLabel.textColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 20)
        followingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(followingLabel)
        
        
        let followingCount = UILabel()
        followingCount.text = "55"
        followingCount.font = .systemFont(ofSize: 14)
        followingCount.textAlignment = .center
        followingCount.textColor = .white
        followingCount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(followingCount)
        
        
        let logoutButton = UIButton()
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 20), for: .normal)
        logoutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100), // Set the width based on your preference
            imageView.heightAnchor.constraint(equalToConstant: 100), // Set the height based on your preference
            
            ProfileSetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -140),
            ProfileSetButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),
            
            
            profileName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            
            postlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postlabel.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 20),
            
            postCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postCount.topAnchor.constraint(equalTo: postlabel.bottomAnchor, constant: 10),
            
            followingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            followingLabel.topAnchor.constraint(equalTo: postlabel.bottomAnchor, constant: 30),
            
            followingCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            followingCount.topAnchor.constraint(equalTo: followingLabel.bottomAnchor, constant: 10),
            
            followersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            followersLabel.topAnchor.constraint(equalTo: followingLabel.bottomAnchor, constant: 35),
            
            followersCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            followersCount.topAnchor.constraint(equalTo: followersLabel.bottomAnchor, constant: 10),
            
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            
            
            
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

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            imageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    @objc func logOutButtonTapped()  {
        UserDefaults.standard.set(false, forKey: "Isloggedin")
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    

}

