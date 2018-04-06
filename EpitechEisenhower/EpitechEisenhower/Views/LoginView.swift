//
//  LoginView.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 24/03/2018.
//

import UIKit

class LoginView: UIView {    
    private let emailTextField: UITextField?
    private let passwordTextField: UITextField?
    private let CORNER_RADIUS_VIEW: CGFloat = 8.0
    private let errorLabel: UILabel?
    private let PASSWORD_MULTIPLICATOR: CGFloat = 0.55
    private let EMAIL_MULTIPLICATOR: CGFloat = 0.2
    
    public var error: String {
        didSet {
            errorLabel?.text = error
        }
    }
    
    public var email: String {
        get {
            if let emaiStr = emailTextField?.text {
                return emaiStr
            }
            return ""
        }
    }
    
    public var password: String {
        get {
            if let passwordStr = passwordTextField?.text {
                return passwordStr
            }
            return ""
        }
    }

    override init(frame: CGRect) {
        emailTextField = UITextField(frame: CGRect(x: 0, y: 71, width: 343, height: 65))
        passwordTextField = UITextField(frame: CGRect(x: 0, y: 192, width: 343, height: 65))
        errorLabel = UILabel(frame: CGRect(x: 0, y: 267, width: 343, height: 25))
        error = ""
                
        super.init(frame: frame)
        createEmailTextfield()
        createPasswordTextfield()
        createErrorLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        emailTextField = UITextField(frame: CGRect(x: 0, y: 71, width: 343, height: 65))
        passwordTextField = UITextField(frame: CGRect(x: 0, y: 192, width: 343, height: 65))
        errorLabel = UILabel(frame: CGRect(x: 0, y: 267, width: 343, height: 25))
        error = ""
        
        super.init(coder: aDecoder)
        createEmailTextfield()
        createPasswordTextfield()
        createErrorLabel()
    }
    
    
    private func createEmailTextfield() {
        configureDefaultSettings(textField: emailTextField!)
        addCommunContraints(view: emailTextField!)
        let positionContraint = NSLayoutConstraint(item: emailTextField!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: EMAIL_MULTIPLICATOR * self.frame.height)
        self.addConstraint(positionContraint)
        
        emailTextField!.text = "Your Email"
        if #available(iOS 10.0, *) {
            emailTextField!.textContentType = UITextContentType.emailAddress
        }
        emailTextField!.keyboardType = .emailAddress
        
        self.addSubview(emailTextField!)
    }
    
    private func createPasswordTextfield() {
        configureDefaultSettings(textField: passwordTextField!)
        addCommunContraints(view: passwordTextField!)
        let positionContraint = NSLayoutConstraint(item: passwordTextField!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: PASSWORD_MULTIPLICATOR * self.frame.height)
        self.addConstraint(positionContraint)
        passwordTextField!.text = "Password"
        passwordTextField!.isSecureTextEntry = true
        if #available(iOS 11.0, *) {
            passwordTextField!.textContentType = UITextContentType.password
        }
        passwordTextField?.keyboardType = .default
        self.addSubview(passwordTextField!)
    }

    private func createErrorLabel() {
        error = ""
        errorLabel!.numberOfLines = 0
        errorLabel!.textColor = UIColor.white
        errorLabel!.font = UIFont.systemFont(ofSize: 12)
        errorLabel!.textAlignment = .center
        addCommunContraints(view: errorLabel!)
        let positionConstrait = NSLayoutConstraint(item: errorLabel!, attribute: .top, relatedBy: .equal, toItem: passwordTextField, attribute: .bottom, multiplier: 1, constant: 5)
//
        self.addConstraint(positionConstrait)
        self.addSubview(errorLabel!)
    }
    
    private func configureDefaultSettings(textField: UITextField) {
        textField.backgroundColor = #colorLiteral(red: 0.1337784827, green: 0.6588404179, blue: 0.7277467847, alpha: 1)
        textField.layer.cornerRadius = CORNER_RADIUS_VIEW
        textField.textColor = UIColor.white
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.clearsOnBeginEditing = true
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
//        textField.font = UIFont(name: "SF Light", size: 18)
        if #available(iOS 8.2, *) {
            textField.font = UIFont.systemFont(ofSize: 18, weight: .light)
        }
        if #available(iOS 11.0, *) {
            textField.smartDashesType = .no
            textField.smartQuotesType = .no
        }
    }
    
    private func addCommunContraints(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let rightContraint = NSLayoutConstraint.init(item: view, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
        let heightContraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 65)
        let centerXContraint = NSLayoutConstraint(item: view, attribute:.centerX , relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let leftContraint = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        self.addConstraints([rightContraint, heightContraint, centerXContraint, leftContraint])
    }
}
