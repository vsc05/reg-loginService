//
//  LoginViewController.swift
//  Pearl
//
//  Created by Lada Priora 2 on 01.06.2025.
//

import UIKit

class LoginView: UIViewController {
    private var viewBuilder = ViewBuilder()
    private let service = AuthService()

    lazy var titleLabel = viewBuilder.createLabel(
        frame: CGRect(x: -110, y: 100, width: view.frame.width - 60, height: 40),
        text: "Вход",
        size: 22
    )

    lazy var emailTextField = viewBuilder.createTextField(
        frame: CGRect(x: 30, y: titleLabel.frame.maxY + 40, width: view.frame.width - 60, height: 50),
        placeholder: "Email"
    )

    lazy var passwordTextField = viewBuilder.createTextField(
        frame: CGRect(x: 30, y: emailTextField.frame.maxY + 20, width: view.frame.width - 60, height: 50),
        placeholder: "Password",
        isPassword: true
    )

    lazy var loginButton = viewBuilder.createFilledButton(
        frame: CGRect(x: 30, y: passwordTextField.frame.maxY + 420, width: view.frame.width - 60, height: 50),
        title: "Войти",
        action: loginAction
    )
    
    
    lazy var goBackButton = viewBuilder.createButton(
        frame: CGRect(x: 30, y: loginButton.frame.maxY + 20, width: view.frame.width - 60, height: 50),
        title: "Назад",
        action: goBackAction
    )
    
    lazy var goBackAction: UIAction = UIAction { _ in
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "routeVC"),
            object: nil,
            userInfo: ["vc": WindowCase.reg]
        )
    }
    
    lazy var loginAction: UIAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        let user = UserData(email: email, password: password)
        service.signIn(user: user) { result in
            switch result {
            case .success(let user):
                NotificationCenter.default.post(
                    name: Notification.Name(rawValue: "routeVC"),
                    object: nil,
                    userInfo: ["vc": WindowCase.home]
                )
            case .failure(let error):
                print(error)
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        [titleLabel, emailTextField, passwordTextField, loginButton, goBackButton].forEach { view.addSubview($0) }
    }
}
