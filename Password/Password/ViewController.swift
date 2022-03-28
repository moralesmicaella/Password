//
//  ViewController.swift
//  Password
//
//  Created by Micaella Morales on 3/26/22.
//

import UIKit

class ViewController: UIViewController {
    
    let stackView = UIStackView()
    let newPasswordView = PasswordView(placeholder: "New Password")
    let statusView = PasswordStatusView()
    let confirmPasswordView = PasswordView(placeholder: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }

}

// MARK: - SETUP, STYLE AND LAYOUT
extension ViewController {
    private func setup() {
        setupNewPassword()
        setupConfirmPassword()
        setupDismissKeyboardGesture()
    }
    
    private func setupNewPassword() {
        let newPasswordValidation: CustomValidation = { text in
            
            // Empty text
            guard let text = text, !text.isEmpty else {
                self.statusView.reset()
                return (false, "Enter your password")
            }
            
            // Valid characters @:?!()$#^%&,./\\\\
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$^%&\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.statusView.reset()
                return (false, "Enter valid special chars (.,@:?!()$^%&\\/#) with no spaces")
            }
            
            // Criteria met
            self.statusView.updateDisplay(text)
            if !self.statusView.validate(text) {
                return (false, "Your password must meet the requirements below")
            }
            
            return (true, "")
        }
        
        newPasswordView.customValidation = newPasswordValidation
    }
    
    private func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password.")
            }
            
            guard text == self.newPasswordView.text else {
                return (false, "Passwords do not match.")
            }
            
            return (true, "")
        }
        
        confirmPasswordView.customValidation = confirmPasswordValidation
    }
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        newPasswordView.translatesAutoresizingMaskIntoConstraints = false
        newPasswordView.delegate = self
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        
        confirmPasswordView.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordView.delegate = self
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: .normal)
        resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
    }
    
    private func layout() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(newPasswordView)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordView)
        stackView.addArrangedSubview(resetButton)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
        
    }
}

// MARK: - ACTIONS
extension ViewController {
    @objc private func resetPasswordButtonTapped() {
        _ = confirmPasswordView.validate()
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func updateStatusViewDisplay(_ sender: PasswordView) {
        if sender === newPasswordView {
            if let text = sender.passwordTextField.text {
                statusView.updateDisplay(text)
            }
        }
    }
}

// MARK: - PasswordViewDelegate
extension ViewController: PasswordViewDelegate {
    func editingDidBegin(_ sender: PasswordView) {
        statusView.shouldResetCriteria = true
        sender.clearError()
        updateStatusViewDisplay(sender)
    }
    
    func editingChanged(_ sender: PasswordView) {
        updateStatusViewDisplay(sender)
    }
    
    func editingDidEnd(_ sender: PasswordView) {
        statusView.shouldResetCriteria = false
        _ = sender.validate()
    }
}
