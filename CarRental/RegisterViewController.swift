//
//  RegistrationViewController.swift
//  CarRental
//
//  Created by Ferid Suleymanzade on 25.07.26.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    var users = [User]()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Yeni hesab yarat"
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Adınız"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Şifrə"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Daxil ol", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Registration"
        
        setupUI()
        setupAction()
    }
    
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        
        
        NSLayoutConstraint.activate([
            
            //title
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            registerButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    private func setupAction() {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func  registerButtonTapped() {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let user = User(name: name, email: email, password: password)
        
        FileManagerService.shared.saveUser(user)
        
        let popup = CustomPopupViewController(
            title: "Registration Successfull",
            message: "Your account has been successfully created.",
            buttonTitle: "Ok"
        ){[weak self] in
            
            self?.navigationController?.popViewController(animated: true)
        }
        
        present(popup, animated: true)
    }
}
