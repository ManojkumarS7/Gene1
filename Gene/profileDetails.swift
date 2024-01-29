//
//  profileDetails.swift
//  Gene
//
//  Created by manoj on 28/12/23.
//

import UIKit

class ProfileDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        let closeButton = UIButton()
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        
        
        let profileView = UIButton()
        profileView.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        profileView.transform = CGAffineTransform(scaleX: 3, y: 3)
        profileView.tintColor = .white
        profileView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileView)

       let profileName = UILabel()
        profileName.text = "USER"
        profileName.font = .systemFont(ofSize: 20)
        profileName.textAlignment = .center
        profileName.textColor = .white
        profileName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileName)
        
        let postlabel = UILabel()
         postlabel.text = "POST"
         postlabel.font = .systemFont(ofSize: 15)
         postlabel.textAlignment = .center
         postlabel.textColor = .white
         postlabel.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(postlabel)
        
        let postCount = UILabel()
        postCount.text = "0"
        postCount.font = .systemFont(ofSize: 14)
        postCount.textAlignment = .center
        postCount.textColor = .white
        postCount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postCount)
        
        
        let followersLabel = UILabel()
        followersLabel.text = "Followers"
        followersLabel.font  = .systemFont(ofSize: 15)
        followersLabel.textAlignment = .center
        followersLabel.textColor = .white
        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(followersLabel)
        
        let followersCount = UILabel()
        followersCount.text = "0"
      followersCount.font = .systemFont(ofSize: 14)
        followersCount.textAlignment = .center
    followersCount.textColor = .white
        followersCount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(followersCount)
        
        let followingLabel = UILabel()
        followingLabel.text = "Following"
        followingLabel.font = .systemFont(ofSize: 15)
        followingLabel.textAlignment = .center
        followingLabel.textColor = .white
        followingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(followingLabel)
        
        
        let followingCount = UILabel()
     followingCount.text = "0"
       followingCount.font = .systemFont(ofSize: 14)
     followingCount.textAlignment = .center
   followingCount.textColor = .white
    followingCount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(followingCount)

        
        let logoutButton = UIButton()
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
       // logoutButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            profileView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            profileView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          //  profileView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            profileName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileName.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 20),
            
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

         
            
            
           
        
        
     
        
    }
    
    @objc func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

    
}

