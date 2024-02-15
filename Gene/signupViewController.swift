//
//  signupViewController.swift
//  Gene
//
//  Created by manoj on 09/01/24.
//




import UIKit


@available(iOS 17.0, *)

class signupViewController: UIViewController {
    
    var goto = homePageViewController()
    
   
     var scrollView : UIScrollView = {
        
        let scrollView = UIScrollView()
         scrollView.showsHorizontalScrollIndicator = false
         scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let headTitle : UILabel = {
        let label = UILabel()
        label.text = "G e n e"
        label.textAlignment = .center
        label.textColor = .init(red: 1.5, green: 0.5, blue: 0.5, alpha: 0.5)
        label.font = .preferredFont(forTextStyle: .extraLargeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
     
        
    }()
    
    let backToLogin : UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Already have account", for: .normal)
        button.setTitleColor(.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backtoLogin), for: .touchUpInside)
        return button
    }()
    
//    button.setTitleColor(.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5), for: .normal)

    let userNameLabel : UILabel = {
        let label = UILabel()
        label.text = "N A M E :"
        label.font = .systemFont(ofSize: 15)
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

  
    let userNameTextField : UITextField = {
        
        let textField = UITextField(frame: .zero)
        
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 2.5
        textField.layer.cornerRadius = 10.0
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .systemGray5
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return textField
    }()
    let emailLabel : UILabel = {
        
        let label = UILabel()
        label.text = "E M A I L :"
        label.font = .systemFont(ofSize: 15)
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField : UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Enetr your email"
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 2.5
        textField.layer.cornerRadius = 10.0
        
        textField.backgroundColor = .systemGray5
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        return textField
    }()
    
    let passwordLabel : UILabel = {
        
        let label = UILabel()
        label.text = "P A S S W O R D:"
        label.font = .systemFont(ofSize: 15)
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 2.5
        textField.layer.cornerRadius = 10.0
        
        textField.backgroundColor = .systemGray5
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return textField
    }()
    
    let confirmpasswordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
      
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 2.5
        textField.layer.cornerRadius = 10.0
        
        textField.backgroundColor = .systemGray5
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return textField
    }()
    
    let phnnoLabel : UILabel = {
        
        let label = UILabel()
        label.text = "P H O N E  N O:"
        label.font = .systemFont(ofSize: 15)
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phnNoTextField : UITextField = {
        
        let textField = UITextField(frame: .zero)
        textField.keyboardAppearance  = .default
        textField.keyboardType = .numberPad
        textField.placeholder = "+91"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 2.5
        textField.layer.cornerRadius = 10.0
        
        textField.backgroundColor = .systemGray5
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        return textField
    }()
  
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Signup", for: .normal)
        button.backgroundColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signupButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    let facebooksignupButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "fb")?.resize(targetSize: CGSize(width: 30, height: 30)), for: .normal)
    
        
        button.setTitle("Sign up with facebook", for: .normal)
        button.setTitleColor(.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5), for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1.0
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 50, bottom: 15, right: 50)
        button.layer.borderColor = UIColor.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let googlesignupButton: UIButton = {
        
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(named: "google")?.resize(targetSize: CGSize(width: 30, height: 30)), for: .normal)
        button.setTitle("Sign up with google",  for: .normal)
        button.setTitleColor(.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5), for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1.0
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 60, bottom: 10, right: 60)
        button.layer.borderColor = UIColor.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
     
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
              scrollView.addSubview(headTitle)
              scrollView.addSubview(userNameLabel)
              scrollView.addSubview(userNameTextField)
              scrollView.addSubview(emailLabel)
              scrollView.addSubview(emailTextField)
              scrollView.addSubview(passwordLabel)
              scrollView.addSubview(passwordTextField)
              scrollView.addSubview(confirmpasswordTextField)
              scrollView.addSubview(phnnoLabel)
              scrollView.addSubview(phnNoTextField)
              scrollView.addSubview(signupButton)
              scrollView.addSubview(backToLogin)
             scrollView.addSubview(facebooksignupButton)
             scrollView.addSubview(googlesignupButton)
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
     

        NSLayoutConstraint.activate([
       
            
                     scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                     headTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
                     headTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                     
                   
                     userNameLabel.topAnchor.constraint(equalTo: headTitle.bottomAnchor, constant: 20),
                     userNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                     userNameLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),

                     // Username Text Field Constraints
                     userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
                     userNameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                     userNameTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),

                     // Email Label Constraints
                     emailLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
                     emailLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                     emailLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),

                     // Email Text Field Constraints
                     emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
                     emailTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                     emailTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),

                     // Password Label Constraints
                     passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
                     passwordLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                     passwordLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),

                     // Password Text Field Constraints
                     passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
                     passwordTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                     passwordTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),

                     // Confirm Password Text Field Constraints
                     confirmpasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
                     confirmpasswordTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                     confirmpasswordTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),

                     // Phone Number Label Constraints
                     phnnoLabel.topAnchor.constraint(equalTo: confirmpasswordTextField.bottomAnchor, constant: 20),
                     phnnoLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                     phnnoLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),

                     // Phone Number Text Field Constraints
                     phnNoTextField.topAnchor.constraint(equalTo: phnnoLabel.bottomAnchor, constant: 10),
                     phnNoTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                     phnNoTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),

                     // Signup Button Constraints
                     signupButton.topAnchor.constraint(equalTo: phnNoTextField.bottomAnchor, constant: 60),
                     signupButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                     
                     facebooksignupButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 20),
                     facebooksignupButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                     
                     googlesignupButton.topAnchor.constraint(equalTo: facebooksignupButton.bottomAnchor, constant: 20),
                     googlesignupButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

                     // Back to Login Button Constraints
                     backToLogin.topAnchor.constraint(equalTo: googlesignupButton.bottomAnchor, constant: 20),
                     backToLogin.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,  constant: 65),
                     backToLogin.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
                     backToLogin.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)

                    


        ])
    

  
    }
    
    @objc func signupButtonPressed(_ sender: UIButton) {
        // Instantiate an instance of HomePageViewController
        
        
        
        
        
        
        
                guard let username = userNameTextField.text, !username.isEmpty,
                      let email = emailTextField.text, !email.isEmpty,
                      let password = passwordTextField.text , !password.isEmpty,
                      let confirmPassword = confirmpasswordTextField.text, !confirmPassword.isEmpty,
                      let phoneNumber = phnNoTextField.text, !phoneNumber.isEmpty
             
             
             else {
                    
                    showAlter(title: "Error", message: "Please fill in all fields.")
                    return
                }
                guard password == confirmPassword else {
                    
                    showAlter(title: "Error", message: "Passwords do not match.")
                    
                    return
                }
            
        
        
                let parameters : [String: Any] = [
                    
                    "username" : username,
                    "email" : email,
                    "passwd" : password,
                    "confirm_passwd" : confirmPassword,
                    "phnno" : phoneNumber
                    
                ]
                
                let url = URL(string:"http://10.10.101.92:8000/api/signup")
      //  let url = URL(string:"http://127.0.0.1:8000/api/signup")
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                
                
               
                
                do {
                    
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    
                } catch let erorr{
                    
                    print(erorr.localizedDescription)
                    return
                }
                
                let task = URLSession.shared.dataTask(with: request) { [self] ( data, response, error) in
                    if let error = error {
                        
                        print("Post Requset Error: \(error.localizedDescription)")
                    return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        
                        print("Invalid Resoponse Recived From the Server")
                    return
                    }
                    
                    if let data = data , let token = String(data: data, encoding: .utf8) {
                        print("Token recived : \(token)")
                        authGlobal.authString = token
                        UserDefaults.standard.setValue(token, forKey: "AuthToken")
                        
        
                        var authenticatedRequest = URLRequest(url: url!)
                        authenticatedRequest.httpMethod = "GET"
                        authenticatedRequest.setValue(token, forHTTPHeaderField: "Authorization")
                        DispatchQueue.main.async {
                            
                            
                            let homeViewController = homePageViewController()
                           // homeViewController.authToken = token
                            
                         //   homeViewController.modalPresentationStyle = .fullScreen
                            navigationController?.pushViewController(homeViewController, animated: true)
                        }
                    } else {
                        print("nil data recived from the server")
                        
                    }
            
                }
                task.resume()
//        let homeViewController = homePageViewController()
//        homeViewController.authToken = token
//        homeViewController.modalPresentationStyle = .fullScreen
//        present(homeViewController, animated: true, completion: nil)
    }
    
    
    
    @objc func backtoLogin() {
        
     //   let goto = LoginViewController()
        
      dismiss(animated: true, completion: nil)
    }


    private func showAlter(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    }

    


