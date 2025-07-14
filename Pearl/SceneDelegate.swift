//
//  SceneDelegate.swift
//  Pearl
//
//  Created by Lada Priora 2 on 01.06.2025.
//

import UIKit

enum WindowCase {
    case login
    case reg
    case home
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let authService = AuthService()
    func scene(_ scene: UIScene,
                willConnectTo session: UISceneSession,
                options connectionOptions: UIScene.ConnectionOptions) {

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(routeVC(notification:)),
            name: Notification.Name(rawValue: "routeVC"),
            object: nil
        )

        guard let scene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow(windowScene: scene)
        if authService.isLogin() {
            self.window?.rootViewController = windowManager(vc: .home)
        } else {
            self.window?.rootViewController = windowManager(vc: .reg)
        }
        self.window?.makeKeyAndVisible()
    }

    private func windowManager(vc: WindowCase) -> UIViewController {
        switch vc {
        case .login:
            return LoginView()
        case .reg:
            return RegView()
        case .home:
            return UINavigationController(rootViewController: HomeView())
        }
    }

    @objc func routeVC(notification: Notification) {
        guard let userInfo = notification.userInfo,
                let vc = userInfo["vc"] as? WindowCase else { return }

        self.window?.rootViewController = windowManager(vc: vc)
    }
}

