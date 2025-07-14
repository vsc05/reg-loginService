//
//  ViewBuilder.swift
//  Pearl
//
//  Created by Lada Priora 2 on 02.06.2025.
//

import UIKit

class ViewBuilder {
    func createLabel(frame: CGRect, text: String, size: CGFloat) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = .systemFont(ofSize: size, weight: .bold)
        label.textAlignment = .center
        return label
    }

    func createTextField(frame: CGRect, placeholder: String, isPassword: Bool = false) -> UITextField {
        let tf = UITextField(frame: frame)
        tf.placeholder = placeholder
        tf.backgroundColor = .systemGray6
        tf.isSecureTextEntry = isPassword
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        return tf
    }

    func createFilledButton(frame: CGRect, title: String, action: UIAction) -> UIButton {
        let btn = UIButton(type: .system, primaryAction: action)
        btn.frame = frame
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        return btn
    }
    
    func createButton(frame: CGRect, title: String, action: UIAction) -> UIButton {
        let btn = UIButton(type: .system, primaryAction: action)
        btn.frame = frame
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = .none
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.layer.cornerRadius = 8
        return btn
    }
}

