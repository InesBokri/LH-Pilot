//
//  RegistrationViewController.swift
//  LH-Pilot
//
//  Created by Ines BOKRI on 06/12/2023.
//

import Foundation
import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    public var viewModel: RegistrationViewModel!
    var validPassword: Bool = false
    var validConfirmPassword: Bool = false
    var validLicenseType: Bool = false
    var validName: Bool = false

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var licenseTypeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var confirmPasswordTextField: UITextField! {
        didSet {
            confirmPasswordTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var nameErrorLabel: UILabel! {
        didSet {
            nameErrorLabel.isHidden = true
        }
    }
    @IBOutlet weak var licenseTypeErrorLabel: UILabel! {
        didSet {
            licenseTypeErrorLabel.isHidden = true
        }
    }
    @IBOutlet weak var passwordErrorLabel: UILabel! {
        didSet {
            passwordErrorLabel.isHidden = true
        }
    }
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel! {
        didSet {
            confirmPasswordErrorLabel.isHidden = true
        }
    }
    @IBOutlet weak var registerButton: UIButton! {
        didSet {
            registerButton.layer.cornerRadius = 8
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RegistrationViewModel()
        setupViews()
        viewModel.fechData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = true
        clearAllData()
    }
    
    // MARK: - Functions
    private func setupViews() {
        nameTextField.delegate = self
        nameTextField.clearsOnBeginEditing = false
        
        licenseTypeTextField.delegate = self
        licenseTypeTextField.clearsOnBeginEditing = false
        
        passwordTextField.delegate = self
        passwordTextField.clearsOnBeginEditing = false
        
        confirmPasswordTextField.delegate = self
        confirmPasswordTextField.clearsOnBeginEditing = false
        
        if let myImage = UIImage(named: "name") {
            nameTextField.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.blue, colorBorder: UIColor.black)
        }
        
        if let myImage = UIImage(named: "licenseType") {
            licenseTypeTextField.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.blue, colorBorder: UIColor.black)
        }
        
        if let myImage = UIImage(named: "password") {
            passwordTextField.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.blue, colorBorder: UIColor.black)
            confirmPasswordTextField.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.blue, colorBorder: UIColor.black)
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            nameErrorLabel.isHidden = true
        case licenseTypeTextField:
            licenseTypeErrorLabel.isHidden = true
        case passwordTextField:
            passwordErrorLabel.isHidden = true
        case confirmPasswordTextField:
            confirmPasswordErrorLabel.isHidden = true
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case nameTextField:
            nameErrorLabel.isHidden = true
        case licenseTypeTextField:
            licenseTypeErrorLabel.isHidden = true
        case passwordTextField:
            passwordErrorLabel.isHidden = true
        case confirmPasswordTextField:
            confirmPasswordErrorLabel.isHidden = true
        default:
            break
        }
        
        return true
    }
    
    private func clearAllData() {
        nameTextField.text = ""
        licenseTypeTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        
        validName = false
        validLicenseType = false
        validPassword = false
        validConfirmPassword = false
    }

    @IBAction func registerButtonTapped(sender: UIButton) {
        if nameTextField.isEmpty {
            nameTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            nameErrorLabel.isHidden = false
        } else if nameTextField.text?.count == 1 && nameTextField.containsWhitespace {
            nameTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            nameErrorLabel.isHidden = false
        } else {
            nameErrorLabel.isHidden = true
            validName = true
        }
        
        if !viewModel.checkLicenseTypeValidity(licenseTypeTextField.text ?? "") {
            licenseTypeTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            licenseTypeErrorLabel.isHidden = false
        } else {
            validLicenseType = true
        }
        
        if !viewModel.checkPasswordValidity(passwordTextField.text ?? "", nameTextField.text ?? "") {
            passwordTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            passwordErrorLabel.isHidden = false
        } else {
            validPassword = true
        }
        
        if !viewModel.checkConfirmPasswordValidity(confirmPasswordTextField.text ?? "", passwordTextField.text ?? "") {
            confirmPasswordTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            confirmPasswordErrorLabel.isHidden = false
        } else {
            validConfirmPassword = true
        }
        
        if validName == true && validLicenseType == true && validPassword == true && validConfirmPassword == true {
            navigateToConfirmationView()
        }
    }
    
    // MARK: - Navigation
    private func navigateToConfirmationView() {
        let vc = UIStoryboard.init(name: "ConfirmationViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "ConfirmationViewController") as! ConfirmationViewController
        
        if let userName = nameTextField.text,
           let licenseType = licenseTypeTextField.text {
            vc.userName = userName
            vc.licenseType = licenseType
            vc.aircrafts = viewModel.getAirCraftFromLicenseType(licenseType)
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
