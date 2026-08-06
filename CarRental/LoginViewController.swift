//
//  LoginViewController.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 25.07.26.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let backImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "car")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let backgroundBlueView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue.withAlphaComponent(0.9)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "car-renting")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "Email"
        textField.backgroundColor = .white
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 25
        textField.clipsToBounds = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .none
        textField.backgroundColor = .white
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 25
        textField.clipsToBounds = true
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textContentType = .newPassword
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Don't have an account? Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginSetupView()
        setupActions()
        setupPasswordField()
        
        
    }
    
    private func setupKeyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func  dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    private func loginSetupView() {
        
        view.addSubview(backImageView)
        view.addSubview(backgroundBlueView)
        view.addSubview(imageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        
        
        NSLayoutConstraint.activate([
            
            //backgroundImage
            backImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //backgroundBlue
            backgroundBlueView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundBlueView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundBlueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundBlueView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //image
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            
            //Email
            emailTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            //Password
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            //button
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            //registerButton
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        
        let isValid = CoreDataService.shared.loginUser(email: email, password: password)
        
        if isValid {
            
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            
         let mainTabbar = MainTabBarController()
            
            navigationController?.setViewControllers(
                [mainTabbar],
                animated: true
            )
        } else {
            let popup = CustomPopupViewController(
                title: "Login Failed",
                message: "Email or password is incorrect.",
                buttonTitle: "OK"
            )
            
            present(popup, animated: true)
        }
        
    }
    
    private func setupPasswordField() {
        
        let button = UIButton(type: .system)
        
        button.setImage(
            UIImage(systemName: "eye.slash"),
            for: .normal
        )
        
        button.tintColor = .secondaryLabel
        
        button.addTarget(
            self,
            action: #selector(togglePasswordVisibility),
            for: .touchUpInside
        )
        
        passwordTextField.rightView = button
        passwordTextField.rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility() {
        
        passwordTextField.isSecureTextEntry.toggle()
        
        let imageName = passwordTextField.isSecureTextEntry
            ? "eye.slash"
            : "eye"
        
        if let button = passwordTextField.rightView as? UIButton {
            button.setImage(
                UIImage(systemName: imageName),
                for: .normal
            )
        }
    }
    
    @objc private func registerButtonTapped() {
        
        let registerVC = RegistrationViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}
