
 

import UIKit

@available(iOS 17.0, *)
class LoginViewController : UIViewController, UITextFieldDelegate {
    
    //var authToken : String?
    
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
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "U S E R  N A M E :"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.textColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5)
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your username or Email"
        //textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.keyboardAppearance = .light
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .default
        textField.autocorrectionType = .no
      
        textField.clearButtonMode = .whileEditing
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 2.5
        textField.layer.cornerRadius = 10.0
        textField.backgroundColor = .systemGray5
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true // Adjust width as needed
           textField.heightAnchor.constraint(equalToConstant: 60).isActive = true // Adjust height as needed
        return textField
    }()

    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "P A S S W O R D :"
        label.textColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5)
        label.textAlignment = .center
        
        label.font = .systemFont(ofSize: 15)
        label.font = .preferredFont(forTextStyle: .headline)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        //textField.textColor = .white
     
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

    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()

    
    let facebookLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "fb")?.resize(targetSize: CGSize(width: 30, height: 30)), for: .normal)
    
        
        button.setTitle("Sign in with facebook", for: .normal)
        button.setTitleColor(.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5), for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1.0
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 50, bottom: 15, right: 50)
        button.layer.borderColor = UIColor.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let googleLoginButton: UIButton = {
        
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(named: "google")?.resize(targetSize: CGSize(width: 30, height: 30)), for: .normal)
        button.setTitle("Sign in with google",  for: .normal)
        button.setTitleColor(.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5), for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1.0
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 60, bottom: 10, right: 60)
        button.layer.borderColor = UIColor.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signupButton : UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("New User? Create Account.", for: .normal)
        button.setTitleColor(.init(red: 0.5, green: 1.5, blue: 2.0, alpha: 0.5), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signupButtonpressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "launch logo 1024")! )
        
        view.addSubview(headTitle)
        

        // Add subviews
//        view.addSubview(usernameLabel)
//        view.addSubview(usernameTextField)
//        view.addSubview(passwordLabel)
//        view.addSubview(passwordTextField)
//        view.addSubview(loginButton)
//        view.addSubview(signupButton)
        view.addSubview(scrollView)
        scrollView.addSubview(usernameLabel)
        scrollView.addSubview(usernameTextField)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(signupButton)
        scrollView.addSubview(facebookLoginButton)
        scrollView.addSubview(googleLoginButton)

        // Add constraints
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            headTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            usernameLabel.topAnchor.constraint(equalTo: headTitle.bottomAnchor, constant: 60),
            usernameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            usernameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
         

            passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),

            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            loginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 100),
            signupButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            facebookLoginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 20),
            facebookLoginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            googleLoginButton.topAnchor.constraint(equalTo: facebookLoginButton.bottomAnchor, constant: 20),
            googleLoginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        if let storedUsername = UserDefaults.standard.string(forKey: "username"),
           let storedPassword = UserDefaults.standard.string(forKey: "pasword") {
            
            usernameTextField.text = storedPassword
            passwordTextField.text = storedPassword
            
        }
        
        func textFieldreturn(_ textfield: UITextField) -> Bool {
            
            textfield.resignFirstResponder()
            return true
        }
    }
 
    @objc func loginButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter username and password")
            return
        }
        
        let parameters: [String: Any] = [
            "email": username,
            "passwd": password
        ]
        
        guard let url = URL(string: "http://10.10.101.92:8000/api/login") else {
            showAlert(message: "Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid Response Received From the Server")
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                        if let data = data, let token = String(data: data, encoding: .utf8) {
                            print("Token Received: \(token)")
                            authGlobal.authString = token
                            UserDefaults.standard.setValue(token, forKey: "AuthToken")
                            DispatchQueue.main.async {
                                
                                let homePage = homePageViewController()
                                self.navigationController?.pushViewController(homePage, animated: true)
                            }
                        } else {
                            print("Nil data received from the server")
                        }
                    } else {
                        // Display an alert message for incorrect username or password
                        DispatchQueue.main.async {
                            self.showAlert(message: "Incorrect username or password")
                        }
                    }
                }
                task.resume()
            }

    
//    @objc func loginButtonTapped(_ sender: UIButton) {
//        guard let username = usernameTextField.text, !username.isEmpty,
//              let password = passwordTextField.text, !password.isEmpty else {
//            showAlert(message: "Please enter username and password")
//            return
//        }
//        
//        // Construct URL with query parameters
//        //        var components = URLComponents(string:"http://10.10.101.92:8000/api/login")
//        //   var components = URLComponents(string:"http://127.0.0.1:8000/api/login")
//        
//        let parameters : [String: Any] = [
//            
//            
//            "email" : username,
//            "passwd" : password,
//            
//        ]
//        
//        //        guard let url = components?.url else {
//        //            showAlert(message: "Invalid URL")
//        //            return
//        //        }
//        
//        let url = URL(string: "http://127.0.0.1:8000/api/login")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//            
//        } catch let erorr{
//            
//            print(erorr.localizedDescription)
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
//            guard let self = self else { return }
//            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
//                self.showAlert(message: "Error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                
//                print("Invalid Resoponse Recived From the Server")
//                return
//            }
//            
//            
//            
//            do {
//                
//                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//                
//            } catch let erorr{
//                
//                print(erorr.localizedDescription)
//                return
//            }
//            
//            let task = URLSession.shared.dataTask(with: request) { [self] ( data, response, error) in
//                if let error = error {
//                    
//                    print("Post Requset Error: \(error.localizedDescription)")
//                    return
//                }
//                
//                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                    
//                    print("Invalid Resoponse Recived From the Server")
//                    return
//                }
//                
//                if let data = data , let token = String(data: data, encoding: .utf8) {
//                    print("Token recived : \(token)")
//                    
//                    UserDefaults.standard.setValue(token, forKey: "AuthToken")
//                    
//                    
//                    var authenticatedRequest = URLRequest(url: url!)
//                    authenticatedRequest.httpMethod = "GET"
//                    authenticatedRequest.setValue(token, forHTTPHeaderField: "Authorization")
//                  
//                    DispatchQueue.main.async {
//                        
//             let homePage = homePageViewController()
//                        self.present(homePage, animated: true)
//                    }
//                } else {
//                    print("nil data recived from the server")
//                    
//                    
//                    
//                }
//                
//            }
//            task.resume()
//        }
//    }
//        let homeViewController = homePageViewController()
//        homeViewController.authToken = token
//        homeViewController.modalPresentationStyle = .fullScreen
//        present(homeViewController, animated: true, completion: nil)
 
 
    
//    func navigationHomepage() {
//        
//        let goto = homePageViewController()
//        navigationController?.pushViewController(goto, animated: true)
//       
//    
//    }
//    
    @objc func signupButtonpressed(_ sender: UIButton) {
   
            
            let goto = signupViewController()
        navigationController?.pushViewController(goto, animated: true)
 
          //  self.present(goto, animated: true, completion:  nil)
            
        
    }
    func showAlert(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    

}
