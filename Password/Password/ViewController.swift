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
    let confirmPasswordTextView = PasswordView(placeholder: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

}

// MARK: - STYLE AND LAYOUT
extension ViewController {
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        newPasswordView.translatesAutoresizingMaskIntoConstraints = false
        newPasswordView.delegate = self
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        
        confirmPasswordTextView.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: .normal)
        resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
    }
    
    private func layout() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(newPasswordView)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextView)
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
        
    }
}

// MARK: - PasswordViewDelegate
extension ViewController: PasswordViewDelegate {
    func editingChanged(_ sender: PasswordView) {
        if let text = sender.passwordTextField.text {
            if sender == newPasswordView {
                statusView.updateDisplay(text)
            }
        }
    }
}
