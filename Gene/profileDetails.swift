//
//  profileDetails.swift
//  Gene
//
//  Created by manoj on 28/12/23.
//

import UIKit

//class ProfileDetailsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
//    
//    //    button.backgroundColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5)
//    //    label.textColor = .init(red: 1.5, green: 0.5, blue: 0.5, alpha: 0.5)
//    
//    //  var user: User?
//    var imageView: UIImageView!
//    let imagePicker = UIImagePickerController()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        view.backgroundColor = .black
//        
//        let closeButton = UIButton()
//        closeButton.setTitle("Close", for: .normal)
//        closeButton.setTitleColor(.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 20), for: .normal)
//        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
//        closeButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(closeButton)
//        
//        
//        
//        imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 50
//        imageView.backgroundColor = .white
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(systemName: "person")
//        imageView.tintColor = .black
//        view.addSubview(imageView)
//      //  let tabGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
//      //  imageView.addGestureRecognizer(tabGesture)
//        
//        let ProfileSetButton = UIButton()
//        ProfileSetButton.setImage(UIImage(systemName: "camera"), for: .normal)
//        ProfileSetButton.tintColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 20)
//        ProfileSetButton.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
//        ProfileSetButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(ProfileSetButton)
//        
//        //        profileImageView.contentMode = .scaleAspectFit
//        //        profileImageView.clipsToBounds = true
//        //        profileImageView.layer.cornerRadius = 50
//        //        profileImageView.translatesAutoresizingMaskIntoConstraints = true
//        //        view.addSubview(profileImageView)
//        
//        let profileName = UILabel()
//        profileName.text = "Mr.X"
//        profileName.font = .systemFont(ofSize: 20)
//        profileName.textAlignment = .center
//        profileName.textColor = .init(white: 10, alpha: 10)
//        profileName.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(profileName)
//        
//        let postlabel = UILabel()
//        postlabel.text = "Post"
//        postlabel.font = .systemFont(ofSize: 15)
//        postlabel.textAlignment = .center
//        postlabel.textColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 20)
//        postlabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(postlabel)
//        
//        let postCount = UILabel()
//        postCount.text = "7"
//        postCount.font = .systemFont(ofSize: 14)
//        postCount.textAlignment = .center
//        postCount.textColor = .white
//        postCount.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(postCount)
//        
//        
//        let followersLabel = UILabel()
//        followersLabel.text = "Followers"
//        followersLabel.font  = .systemFont(ofSize: 15)
//        followersLabel.textAlignment = .center
//        followersLabel.textColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 20)
//        followersLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(followersLabel)
//        
//        let followersCount = UILabel()
//        followersCount.text = "44"
//        followersCount.font = .systemFont(ofSize: 14)
//        followersCount.textAlignment = .center
//        followersCount.textColor = .white
//        followersCount.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(followersCount)
//        
//        let followingLabel = UILabel()
//        followingLabel.text = "Following"
//        followingLabel.font = .systemFont(ofSize: 15)
//        followingLabel.textAlignment = .center
//        followingLabel.textColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 20)
//        followingLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(followingLabel)
//        
//        
//        let followingCount = UILabel()
//        followingCount.text = "55"
//        followingCount.font = .systemFont(ofSize: 14)
//        followingCount.textAlignment = .center
//        followingCount.textColor = .white
//        followingCount.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(followingCount)
//        
//        
//        let logoutButton = UIButton()
//        logoutButton.setTitle("Logout", for: .normal)
//        logoutButton.setTitleColor(.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 20), for: .normal)
//        logoutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
//        logoutButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(logoutButton)
//        
//        NSLayoutConstraint.activate([
//            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            
//            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 100), // Set the width based on your preference
//            imageView.heightAnchor.constraint(equalToConstant: 100), // Set the height based on your preference
//            
//            ProfileSetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -140),
//            ProfileSetButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),
//            
//            
//            profileName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            profileName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
//            
//            postlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            postlabel.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 20),
//            
//            postCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            postCount.topAnchor.constraint(equalTo: postlabel.bottomAnchor, constant: 10),
//            
//            followingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            followingLabel.topAnchor.constraint(equalTo: postlabel.bottomAnchor, constant: 30),
//            
//            followingCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            followingCount.topAnchor.constraint(equalTo: followingLabel.bottomAnchor, constant: 10),
//            
//            followersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            followersLabel.topAnchor.constraint(equalTo: followingLabel.bottomAnchor, constant: 35),
//            
//            followersCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            followersCount.topAnchor.constraint(equalTo: followersLabel.bottomAnchor, constant: 10),
//            
//            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
//            
//            
//            
//            
//        ])
//        
//        
//        
//        
//        imagePicker.delegate = self
//        imagePicker.allowsEditing = true
//    
//        
//    }
//  
//    @objc func profileImageTapped() {
//        presentImagePicker()
//    }
//
//    func presentImagePicker() {
//       
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.allowsEditing = true
//        present(imagePicker, animated: true, completion: nil)
//
//        
//    }
//
//    // MARK: - UIImagePickerControllerDelegate
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let selectedImage = info[.editedImage] as? UIImage {
//            imageView.image = selectedImage
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//    @objc func logOutButtonTapped()  {
//       
//        UserDefaults.standard.removeObject(forKey: "authToken")
//        
//        
//    }
//    
//    @objc func closeButtonPressed() {
//        dismiss(animated: true, completion: nil)
//    }
//    
//
//}
//


class profileViewController: UIViewController {
    
 
    let user = User(userName: "MR._AX_X", following: 100, followers: 100,  posts: ["image1","image2","image3","image4","image5","image6","image7","image8","image9","image10","image11","image12","image13","image14"])
    
    lazy var closeButton : UIButton = {
                let closeButton = UIButton()
                closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
                closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
                closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
                
    }()
    
    
    lazy var editProfile : UIButton = {
        
        let editButton = UIButton()
        editButton.setTitle("Edit Profile", for: .normal)
        editButton.setTitleColor(.black, for: .normal)
        editButton.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        return editButton
    }()
    
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
    

    lazy var username : UILabel = {
        
        let label = UILabel()
        label.text = "\(user.userName)"
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.font = .systemFont(ofSize: 15)

        return label
    }()
    
    lazy var followingLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Following"
        label.textColor = .black
        
        return label
    }()
    
    lazy var followingCount : UILabel = {
        
        let label = UILabel()
        label.text = "\(user.following)"
        label.textColor = .black
        return label
    }()
    
    
    lazy var followersLabel : UILabel =  {
        
        let label = UILabel()
        label.text = "Followers"
        label.textColor = .black
        return label
    }()
    
    lazy var followersCount : UILabel = {
        
        let label = UILabel()
        label.text = "\(user.followers)"
        label.textColor = .black
        return label
        
    }()
    
    lazy var postLabel : UILabel =  {
        
        let label = UILabel()
        label.text = "Posts"
        label.textColor = .black
        return label
    }()
    
    lazy var postCount : UILabel = {
        
        let label = UILabel()
        label.text = "\(user.posts.count)"
        label.textColor = .black
        return label
        
    }()
    
    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 2, height: UIScreen.main.bounds.width / 3 - 2)
        
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: layout)
       // collectionView.backgroundColor =
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .init(red: 0.5, green: 1.5, blue: 1.7, alpha: 1.0)
        view.backgroundColor = .white
        
        view.addSubview(ProfileImageView)

        view.addSubview(username)
        view.addSubview(followingLabel)
        view.addSubview(followingCount)
        view.addSubview(followersLabel)
        view.addSubview(followersCount)
        view.addSubview(collectionView)
        view.addSubview(postLabel)
        view.addSubview(postCount)
        view.addSubview(closeButton)
        view.addSubview(editProfile)
        
        ProfileImageView.translatesAutoresizingMaskIntoConstraints = false
   
        username.translatesAutoresizingMaskIntoConstraints = false
        followingLabel.translatesAutoresizingMaskIntoConstraints = false
        followingCount.translatesAutoresizingMaskIntoConstraints = false
        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        followersCount.translatesAutoresizingMaskIntoConstraints = false
        postLabel.translatesAutoresizingMaskIntoConstraints = false
        postCount.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        editProfile.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
                        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                        
                        editProfile.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                        editProfile.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 20),
            
            ProfileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//            ProfileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        ProfileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ProfileImageView.widthAnchor.constraint(equalToConstant: 100),
            ProfileImageView.heightAnchor.constraint(equalToConstant: 100),
                        
 
                        
            username.topAnchor.constraint(equalTo: view.topAnchor, constant: 102),
            username.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
                        
        
            followingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            followingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            followingCount.topAnchor.constraint(equalTo: followingLabel.bottomAnchor),
            followingCount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        
            
            followersLabel.topAnchor.constraint(equalTo: followingLabel.topAnchor),
           followersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            
            followersCount.topAnchor.constraint(equalTo: followersLabel.bottomAnchor),
            followersCount.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            postLabel.topAnchor.constraint(equalTo: ProfileImageView.bottomAnchor, constant: 100),
            postLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            postCount.topAnchor.constraint(equalTo: postLabel.bottomAnchor),
            postCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: ProfileImageView.bottomAnchor, constant: 150),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        
        ])
             
    }
  
    @objc func closeButtonPressed() {
        
        dismiss(animated: true, completion: nil)
    }
    
       
    
    @objc func editProfileTapped() {
        let goto = editProfileViewController()
        present(goto, animated: true)
        modalPresentationStyle = .fullScreen
        
    }
    
    
}

extension profileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        let imageName = user.posts[indexPath.item]
        cell.imageView.image = UIImage(named: imageName)
        return cell
    }
}

class PostCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
    

        imageView.clipsToBounds = true
        return imageView
    }()
    
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
        contentView.backgroundColor = UIColor.systemGray4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


