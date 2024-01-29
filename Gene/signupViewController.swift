//
//  signupViewController.swift
//  Gene
//
//  Created by manoj on 09/01/24.
//

import UIKit

class signupViewController: UIViewController {

    private let imageView : UIImageView = {
        let Imageview = UIImageView()
        Imageview.image = UIImage(named: "launch logo 1024")
        Imageview.contentMode = .scaleAspectFit
        Imageview.translatesAutoresizingMaskIntoConstraints = false
        return Imageview
    }()
    
    let userNameTextField : UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemYellow
        return textField
    }()
    
    let emailTextField : UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Enetr your email"
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemYellow
        return textField
    }()
    
    let passwordTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.borderStyle = .roundedRect
        textfield.backgroundColor = .systemYellow
        return textfield
    }()
    
    let confirmpasswordTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Confirm Password"
        textfield.isSecureTextEntry = true
        textfield.borderStyle = .roundedRect
        textfield.backgroundColor = .systemYellow
        return textfield
    }()
    
    let signupButton : UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
              button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
              button.translatesAutoresizingMaskIntoConstraints = false
              button.layer.cornerRadius = 3
              button.backgroundColor = UIColor.systemYellow
      //  button.addTarget(self(), action: , for: <#T##UIControl.Event#>)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

      setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [userNameTextField,emailTextField, passwordTextField,confirmpasswordTextField,signupButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
        
        
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -200),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor , constant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        
        
        ])
//
//        NSLayoutConstraint.activate([
//            userNameTextField.heightAnchor.constraint(equalToConstant: 40),
//            emailTextField.heightAnchor.constraint(equalToConstant: 40),
//            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
//            confirmpasswordTextField.heightAnchor.constraint(equalToConstant: 40),
//            signupButton.heightAnchor.constraint(equalToConstant: 40)
//        ])


    }

    

}
