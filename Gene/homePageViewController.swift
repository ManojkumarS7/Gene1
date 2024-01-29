//
//  homePageViewController.swift
//  Gene
//
//  Created by manoj on 15/12/23.
//

import UIKit
import AVFoundation

class homePageViewController: UIViewController {
    var scrollView: UIScrollView!
    var stackView: UIStackView!
   // var profileButton : UIButton!
    
    var refreshControl : UIRefreshControl!
    
    var templateData : geneData!
//    var templateData : geneData!
    
   let openVC = cameraViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        
        let titleAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.yellow,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        view.backgroundColor = .white
        
        
        navigationItem.title = "G e n e"
        
//        let profileButton = UIBarButtonItem(
//        title: "Profile",
//        style: .plain,
//        target: self,
//        action: #selector(profileButtonPressed(_:))
//        
//        )
        
        let profileButton = UIButton(type: .system)
        profileButton.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        profileButton.tintColor = .black
        profileButton.addTarget(self, action: #selector(profileButtonPressed(_:)), for: .touchUpInside)
        profileButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let profileBarBUtoon = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = profileBarBUtoon
        
        
       // scrollView.delegate = self
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        scrollView?.refreshControl = refreshControl
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 90
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        
     
        
        
            
    

        let cameraImage = UIImage(systemName: "livephoto")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let cameraButton = UIButton()
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.setImage(cameraImage, for: .normal)
        cameraButton.transform = CGAffineTransform(scaleX: 3, y: 3)
        cameraButton.addTarget(self, action: #selector(openCamera(_:)), for: .touchUpInside)
        view.addSubview(cameraButton)
            
               
               NSLayoutConstraint.activate([
                   cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   cameraButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
                   cameraButton.widthAnchor.constraint(equalToConstant: 40),
                   cameraButton.heightAnchor.constraint(equalTo: cameraButton.widthAnchor),
                   
         
                   
                   
                   
                   
               ])


        

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
      
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
           
        ])
        
        // Fetch data from the API
        fetchData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            // Update the navigation bar title's alpha based on the scroll direction
            let offsetY = scrollView.contentOffset.y
            let maxOffsetY: CGFloat = 100.0 // Adjust this value based on when you want the title to start fading
            let titleAlpha = 1.0 - min(max(offsetY / maxOffsetY, 0), 1)
            navigationItem.titleView?.alpha = titleAlpha
        }



    
    @objc func profileButtonPressed(_ sender: UIButton) {
              // Create and present the profile details view controller
              let profileDetailsVC = ProfileDetailsViewController() // Replace with the actual view controller for profile details
              profileDetailsVC.modalPresentationStyle = .overFullScreen
              present(profileDetailsVC, animated: true, completion: nil)
          }

    
    @objc func refresh(_ sender: AnyObject) {
       
        fetchData()
    }
    
    
 
  
    
    @objc func openCamera(_ sender: UIButton) {
        
       let opencamera = openVC
      //  opencamera.switchcamera(to: "front")
      
        navigationController?.pushViewController(openVC, animated: true)
        
    }
    @objc func useButtonPressed(_ sender: UIButton){
        print("tag index", sender.tag)
        var select_templateData : geneUserData!
        for Template in templateData.data {
            if Template.ID == sender.tag {
                select_templateData = Template
            }
            
          //  let openCamera = openVC
           
        }
        
     
        
    
            
            //        print("zoomLevel",select_templateData.template_config_data.)
        
        //        do{
        //            if let json = select_templateData.template_config_data.data(using: String.Encoding.utf8){
        //                if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{
        //                  print("zoomLevel",  jsonData["zoomLevel"]?.floatValue ?? Float(0))
        //
        //                   // let zoomLevel = ("zoomLevel", jsonData["ZoomLevel"]?.floatValue ?? Float(0))
        //                    //                    let id = jsonData["zoomLevel"] as! Float
        //
        //
        //                    print("exposureValue", jsonData["exposureValue"]?.floatValue ?? Float(0))
        //                    //  print(type(of: jsonData["zoomLevel"]?.integerValue ))
        //
        //                    //    print(CGFloat(jsonData["zoomLevel"]?.integerValue ?? Int(0) ) )
        //
        //
        //                    let openFilCam = cameraViewController()
        //                 //   openFilCam.updateZoomFactor(CGFloat(zoomLevel))
        //
        //                    navigationController?.pushViewController(openFilCam, animated: true)
        //
        //                }
        //            }
        //        }catch {
        //            print(error.localizedDescription)
        //
        //        }
     //   print(select_templateData.template_config_data)
      
        if let jsonString =  select_templateData.template_config_data {
            if let jsonData = jsonString.data(using: .utf8) {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    
                    if let dict = jsonObject as? [String:Any] {
                        let exposureValue = dict["exposureValue"] as? Float ?? 0.0
                            print(exposureValue)
                        
                        let zoomLevel = dict["zoomLevel"] as? Double ?? 0.0
                            print(zoomLevel)
                        
                        let flashMode = dict["flasMode"] as? Bool
                        print(flashMode as Any)
                        let focusLevel = dict["focusLevel"] as? Float ?? 0.0
                        print(focusLevel)
                 
                        let timer = dict["Timer"] as? Double ?? 0.0
                        print(timer)
                        
                        let AspectRatio = dict["aspectRatio"]
                        print(AspectRatio as Any)
                        
                      let cameralens = dict["cameralens"] as? String
                        print(cameralens as Any)
                        
                        let cameraangle = dict["cameraangle"] as? Double ?? 0.0
                        print(cameraangle)
                        
                        let cameraposition = dict["cameraposition"] as? String
                        print(cameraposition as Any)
                            
                        
                      //  openVC.switchCamera(to: backCamera)
                        openVC.updateZoomFactor(CGFloat(zoomLevel))
                        openVC.updateExposure2(Double(Float(exposureValue)))
                                 // openVC.updateFocus(at:( Float(focusLevel)))
                        //openVC.changeAspectRatio(preset: .AspectRatio as! AVCaptureSession.Preset)
                        openVC.isFlashOn = flashMode ?? false
                        openVC.timerDuration = timer
                        openVC.setAspectRatio(AspectRatio as! String)
                        openVC.setCameralens(cameralens!)
                        openVC.setupMotionManager(finalAngle: cameraangle)
                        openVC.switchcamera(to: cameraposition!)
                      
                     
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            } else {
                print("Failed to convert string to data")
            }
        }   else {
                print("Optional is nil")
            }
        
     
        
     //   openVC.updateZoomFactor(CGFloat((dict["zoomLevel"] as? Float ?? 0)))
      
        navigationController?.pushViewController(openVC, animated: true)
            
        }
    
//      print(select_templateData)
        
//        let apiurl = "http://10.10.101.92:8000/api/gettemplate"
//
//            URLSession.shared.dataTask(with: URL(string: apiurl)!) { [weak self] data, response, error in
//                if let error = error {
//                    print("Error: \(error.localizedDescription)")
//                    return
//                }
//
//                guard let responseData = data else {
//                    print("No data received")
//                    return
//                }
//
//                do {
//                    let templateData = try JSONDecoder().decode(geneData.self, from: responseData)
//
//                
//                    
//                    let tappedimageIndex = sender.tag
//                    
//                    guard tappedimageIndex < templateData.data.count else {
//                      print("Invalid index")
//                        return
//                    }
//
//                    let tappedImage = select_templateData
        //                    print("Template Config Data: \(tappedImage.template_config_data)")
//
//        var json : [ String: Any]
//        
//        if let jsonData = tappedImage?.template_config_data.data(using: .utf8),
//           let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
//                        print("Zoom Level: \(json["zoomLevel"] as? Float ?? 0)")
////                        print("Exposure Value: \(jsonDict["exposureValue"] as? Float ?? 0)")
////                        print("Focus Level: \(jsonDict["focusLevel"] as? Float ?? 0)")
//                    } else {
//                        print("Error parsing template_config_data JSON")
//                    }
//
//                
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
//            }.resume()
//            
//            let openFilCam = cameraViewController()
//        openFilCam.updateZoomFactor(CGFloat((jsonDict["zoomLevel"] as? Float ?? 0)))
            
//            navigationController?.pushViewController(openFilCam, animated: true)
//        
//        
//        let openVC = cameraViewController()
//       navigationController?.pushViewController(openVC, animated: true)
    
 
    
    
    func fetchData() {
       
        let apiUrl = "http://10.10.101.92:8000/api/gettemplate"
        
       
        URLSession.shared.dataTask(with: URL(string: apiUrl)!) {[weak self ] data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
 
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let geneData = try decoder.decode(geneData.self, from: data)
                    self!.templateData = geneData
                 
                    
     
                    DispatchQueue.main.async {
                        self!.processFetchedData(geneData)
                        self!.refreshControl.endRefreshing()
                    }
                    
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
    
    func processFetchedData(_ geneData: geneData) {
       
        for userData in geneData.data {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            

            if let imageUrl = URL(string: userData.thumpnail_url) {
                URLSession.shared.dataTask(with: imageUrl) { [weak self, imageView, userData] imageData, _, error in
                    guard let self = self else { return }
                    
                    if let error = error {
                        print("Error fetching image: \(error.localizedDescription)")
                        return
                    }
                    
                
                    if let imageData = imageData, let image = UIImage(data: imageData) {
                        DispatchQueue.main.async { [self]  in
                            imageView.image = image
                 
                            self.stackView.addArrangedSubview(imageView)
                            
                            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: image.size.width / image.size.height).isActive = true
                            
                            imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
                            
                            
                            let profileImage = UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
                            let profileButton = UIButton()
//                            profileButton.setTitle(userData.Id, for: .normal)
                            profileButton.setTitleColor(.black, for: .normal)
                            profileButton.setImage(profileImage, for: .normal)
                            profileButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                            profileButton.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addSubview(profileButton)

                           
                            let likeImage = UIImage(systemName: "suit.heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
                            let likeButton = UIButton()
                            likeButton.setImage(likeImage, for: .normal)
                            likeButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            likeButton.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addSubview(likeButton)

                   
                            let commandImage = UIImage(systemName: "message")?.withTintColor(.black, renderingMode: .alwaysOriginal)
                            let commentButton = UIButton()
                            commentButton.setImage(commandImage, for: .normal)
                            commentButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            commentButton.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addSubview(commentButton)

                            let usersCountLabel = UILabel()
                            usersCountLabel.text = "\(userData.share_count ?? 0)"
                            usersCountLabel.textColor = .black
                            usersCountLabel.textAlignment = .center
                            usersCountLabel.font = UIFont.systemFont(ofSize: 14)
                            usersCountLabel.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addSubview(usersCountLabel)


                      
                         
                            let likesCountLabel = UILabel()
                            likesCountLabel.text = "\(userData.like_count ?? 0)"
                            likesCountLabel.textColor = .black
                            likesCountLabel.textAlignment = .center
                            likesCountLabel.font = UIFont.systemFont(ofSize: 14)
                            likesCountLabel.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addSubview(likesCountLabel)

                            let userImage = UIImage(systemName: "chevron.up.circle")?.withTintColor(.black, renderingMode: .alwaysOriginal)
                            let useButton = UIButton(type: .system)
                            useButton.setImage(userImage, for: .normal)
                            useButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            useButton.translatesAutoresizingMaskIntoConstraints = false
                            useButton.tag = (userData.ID ?? 0)
                            useButton.addTarget(self, action: #selector(self.useButtonPressed), for: .touchUpInside)
                            self.view.addSubview(useButton)
                        
                            let commentsCountLabel = UILabel()
                            commentsCountLabel.text = "\(userData.comments_count ?? 0)"
                            commentsCountLabel.textColor = .black
                            commentsCountLabel.font = UIFont.systemFont(ofSize: 14)
                            commentsCountLabel.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addSubview(commentsCountLabel)

                      
                            NSLayoutConstraint.activate([
                              
                                profileButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
                                profileButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -23),

                             
                                likeButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
                                likeButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 23),

                              
                                commentButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
                                commentButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),

                               useButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                            useButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),

                                                              
                                                 
                            usersCountLabel.centerXAnchor.constraint(equalTo: useButton.centerXAnchor),
                                usersCountLabel.bottomAnchor.constraint(equalTo: useButton.bottomAnchor, constant: 23),

                             
                        

                                likesCountLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: -15),
                               // likesCountLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
                                likesCountLabel.bottomAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 23),
                                
                                commentsCountLabel.trailingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: -10),
                                commentsCountLabel.bottomAnchor.constraint(equalTo: commentButton.bottomAnchor, constant: 23),
                            ])

                            
                        }
                    }
                }.resume()
                
                
                
                
                
            }
        }
    }
    
  
  
}
