//
//  PasswordView.swift
//  Password
//
//  Created by Micaella Morales on 3/26/22.
//

import UIKit

protocol PasswordViewDelegate:  AnyObject {
    func editingChanged(_ sender: PasswordView)
}

class PasswordView: UIView {
    
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    let passwordTextField = UITextField()
    let eyeButton = UIButton(type: .custom)
    let dividerView = UIView()
    let errorMessageLabel = UILabel()
    
    var placeholder: String
    
    weak var delegate: PasswordViewDelegate?
    
    init(placeholder: String) {
        self.placeholder = placeholder
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - STYLE AND LAYOUT
extension PasswordView {
    private func style() {
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isSecureTextEntry = true
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.secondaryLabel])
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .separator
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.text = "Your password must meet the requirements below."
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.lineBreakMode = .byWordWrapping
        errorMessageLabel.isHidden = true
    }
    
    private func layout() {
        addSubview(lockImageView)
        addSubview(passwordTextField)
        addSubview(eyeButton)
        addSubview(dividerView)
        addSubview(errorMessageLabel)
        
        // Lock Image
        NSLayoutConstraint.activate([
            lockImageView.topAnchor.constraint(equalTo: topAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        lockImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // Password Text Field
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: topAnchor),
            passwordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1),
        ])
        passwordTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        // Eye Button
        NSLayoutConstraint.activate([
            eyeButton.topAnchor.constraint(equalTo: topAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: passwordTextField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        eyeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // Divider
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalToSystemSpacingBelow: passwordTextField.bottomAnchor, multiplier: 1),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // Error Label
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 4),
            errorMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorMessageLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - ACTIONS
extension PasswordView {
    @objc private func togglePasswordView(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    @objc private func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.editingChanged(self)
    }
}

// MARK: - UITextFieldDelegate
extension PasswordView: UITextFieldDelegate {
}

