
 

import UIKit

class LoginViewController : UIViewController {
    
    //    let topView: UIView = {
    //        let view = UIView()
    //        view.backgroundColor = .systemYellow
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    
    
private let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "launch logo 1024")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    
 private  let usernameTextField: UITextField = {
        
     let textField = UITextField(frame: .zero)
        textField.placeholder = "Username or email"
        textField.borderStyle = .roundedRect
       // textField.backgroundColor = .systemYellow
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
   private let passwordTextField: UITextField = {
        
       let textField = UITextField(frame: .zero)
        textField.placeholder = "Password"
        // textField.isSecureTextEntry = true
       // textField.backgroundColor = .systemYellow
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
   private let loginButton : UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 3
        button.backgroundColor = UIColor.systemYellow
       button.addTarget(LoginViewController.self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
   private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create new account", for: .normal)
        button.setTitleColor(.systemYellow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .init(red: 0.3, green: 0.5, blue: 0.5, alpha: 0.7)
        
        
        
//        view.insertSubview(imageView, at: 0)
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -320),
//            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//        
        
        
       
        
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor.black
        
        view.addSubview(imageView)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        
        let stackview = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField,loginButton,signupButton])
        stackview.axis = .vertical
        stackview.spacing = 16
       // stackview.backgroundColor = .systemBlue
        stackview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackview)
        
       NSLayoutConstraint.activate([
            stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
       
          imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
        imageView.widthAnchor.constraint(equalToConstant: 120),
        imageView.heightAnchor.constraint(equalToConstant: 120),

       ])
        
     
    }
    
    
    @objc func loginButtonPressed() {
        
        //        let validUserName = "1234"
        //        let validPassword = "1234"
        //
        guard let username = usernameTextField.text , let password = passwordTextField.text else {
            return
        }
        //
        //        if username == validUserName && pasword == validPassword {
        //            print("Login succesful")
        //            let view = homePageViewController()
        //            navigationController?.pushViewController(view, animated: true)
        //
        //        } else {
        //
        //            print("Invalid username or password. please try again")
        //        }
        
        var request = URLRequest(url: URL(string: "http://10.10.101.92:8000/api/puttemplate" )!)
        request.httpMethod = "POST"
        let postString = "user_id=\(username)&passwd=\(password)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let error = error {
                
                print("Error: \(error)")
                return
            }
            
            guard let data = data , let httpResponse = response as? HTTPURLResponse else {
                print("Inavalid Response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                
                print("Login Succesful")
                
                DispatchQueue.main.async {
                    let HomePage = homePageViewController()
                    self.navigationController?.pushViewController(HomePage, animated: true)
                }
            }
            
        
            
        }
        task.resume()
    }
    
    
    @objc func signupButtonTapped() {
        let signupView = signupViewController()
        navigationController?.pushViewController(signupView, animated: true)
    }
}
//import UIKit
//
//class LoginViewController: UIViewController {
//    
//    let usernameTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Username"
//        textField.borderStyle = .roundedRect
//      //  textField.backgroundColor = .systemYellow
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//    
//    let passwordTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Password"
//        textField.isSecureTextEntry = true
//        textField.borderStyle = .roundedRect
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//    
//    let loginButton: UIButton = {
////        let button = UIButton(type: .system)
////        button.setTitle("Login", for: .normal)
////        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
////        button.translatesAutoresizingMaskIntoConstraints = false
////        return button
//        
//        let button = UIButton(type: .system)
//                button.setTitle("Login", for: .normal)
//                button.setTitleColor(.white, for: .normal)
//                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
//                button.translatesAutoresizingMaskIntoConstraints = false
//                button.layer.cornerRadius = 4
//               button.backgroundColor = .init(red: 0.3, green: 0.44, blue: 0.5, alpha: 0.5)
//               button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
//                return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .init(red: 0.3, green: 0.44, blue: 0.5, alpha: 0.5)
//        
//        setupSubviews()
//    }
//    
//    func setupSubviews() {
//        view.addSubview(usernameTextField)
//        view.addSubview(passwordTextField)
//        view.addSubview(loginButton)
//        
//        NSLayoutConstraint.activate([
//            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
//            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            
//            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
//            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            
//            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
//            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//    }
//    
//    @objc func loginButtonTapped() {
//        // Add your login logic here
//        // For simplicity, let's just print the entered username and password
//  guard let username = usernameTextField.text, let password = passwordTextField.text  else{
//          //  print("Username: \(username), Password: \(password)")
//      
//      return
//        }
//        
//                var request = URLRequest(url: URL(string: "http://10.10.101.92:8000/api/puttemplate" )!)
//                request.httpMethod = "POST"
//                let postString = "user_id=\(username)&passwd=\(password)"
//                request.httpBody = postString.data(using: .utf8)
//                let task = URLSession.shared.dataTask(with: request) {data, response, error in
//        
//                    if let error = error {
//        
//                        print("Error: \(error)")
//                        return
//                    }
//        
//                    guard let data = data , let httpResponse = response as? HTTPURLResponse else {
//                        print("Inavalid Response")
//                        return
//                    }
//        
//                    if httpResponse.statusCode == 200 {
//        
//                        print("Login Succesful")
//        
//                        DispatchQueue.main.async {
//                            let HomePage = homePageViewController()
//                            self.navigationController?.pushViewController(HomePage, animated: true)
//                        }
//                    }
//        
//        
//        
//                }
//                task.resume()
//    }
//}

// Usage in AppDelegate or SceneDelegate
// Uncomment the appropriate line based on your application's entry point

// For AppDelegate:
// let loginViewController = LoginViewController()
// window?.rootViewController = loginViewController

// For SceneDelegate:
// let loginViewController = LoginViewController()
// window?.rootViewController = UINavigationController(rootViewController: loginViewController)
