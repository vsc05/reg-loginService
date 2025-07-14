//
//  RegistrationViewController.swift
//  Pearl
//
//  Created by Lada Priora 2 on 01.06.2025.
//

import UIKit

class RegView: UIViewController {
    private var viewBuilder = ViewBuilder()
    private let service = AuthService()

    lazy var titleLabel = viewBuilder.createLabel(
        frame: CGRect(x: -70, y: 100, width: view.frame.width - 60, height: 40),
        text: "Регистрация",
        size: 22
    )

    lazy var emailTextField = viewBuilder.createTextField(
        frame: CGRect(x: 30, y: titleLabel.frame.maxY + 40, width: view.frame.width - 60, height: 50),
        placeholder: "Email"
    )

    lazy var passwordTextField = viewBuilder.createTextField(
        frame: CGRect(x: 30, y: emailTextField.frame.maxY + 20, width: view.frame.width - 60, height: 50),
        placeholder: "Пароль",
        isPassword: true
    )

    lazy var nameTextField = viewBuilder.createTextField(
        frame: CGRect(x: 30, y: passwordTextField.frame.maxY + 20, width: view.frame.width - 60, height: 50),
        placeholder: "Имя"
    )

    lazy var registerButton = viewBuilder.createFilledButton(
        frame: CGRect(x: 30, y: nameTextField.frame.maxY + 350, width: view.frame.width - 60, height: 50),
        title: "Зарегистрироваться",
        action: registerAction
    )

    lazy var hasAccountButton = viewBuilder.createButton(
        frame: CGRect(x: 30, y: registerButton.frame.maxY + 20, width: view.frame.width - 60, height: 50),
        title: "Уже есть аккаунт?",
        action: toLoginAction
    )

    lazy var registerAction: UIAction = UIAction { [weak self] _ in
        guard let self = self else { return }

        let email = emailTextField.text
        let password = passwordTextField.text
        let name = nameTextField.text

        let user = UserData(email: email ?? "", password: password ?? "", name: name ?? "")
        service.createNewUser(user: user) { result in
            switch result {
            case .success(let success):
                NotificationCenter.default.post(
                    name: Notification.Name(rawValue: "routeVC"),
                    object: nil,
                    userInfo: ["vc": WindowCase.login]
                )
            case .failure(let failure):
                print(failure)
            }
        }
    }

    lazy var toLoginAction: UIAction = UIAction { _ in
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "routeVC"),
            object: nil,
            userInfo: ["vc": WindowCase.login]
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        [titleLabel, emailTextField, passwordTextField, nameTextField, registerButton, hasAccountButton].forEach {
            view.addSubview($0)
        }
    }
}
