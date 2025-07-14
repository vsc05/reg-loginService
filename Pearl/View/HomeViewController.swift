//
//  HomeViewController.swift
//  Pearl
//
//  Created by Lada Priora 2 on 01.06.2025.
//

import UIKit

class HomeView: UIViewController {
    private let service = AuthService()
    private var viewBuilder = ViewBuilder()
    
    lazy var infoLabel = viewBuilder.createLabel(
        frame: CGRect(x: 30, y: 320, width: view.frame.width - 60, height: 50),
        text: "Вы успешно вошли в аккаунт",
        size: 22
    )
    
    lazy var exitButton = viewBuilder.createFilledButton(
        frame: CGRect(x: 30, y: 720, width: view.frame.width - 60, height: 50),
        title: "Выйти",
        action: exitAction
    )
    
    lazy var exitAction: UIAction = UIAction { _ in
        self.service.signOut()
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "routeVC"),
            object: nil,
            userInfo: ["vc": WindowCase.login]
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(exitButton)
        view.addSubview(infoLabel)
    }


}
