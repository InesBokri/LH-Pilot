//
//  ConfirmationViewController.swift
//  LH-Pilot
//
//  Created by Ines BOKRI on 07/12/2023.
//

import Foundation
import UIKit

class ConfirmationViewController: UIViewController {
    
    // MARK: - Properties
    public var viewModel: ConfirmationViewModel!
    public var userName: String = ""
    public var licenseType: String = ""
    public var aircrafts = [String]()
    
    // MARK: - IBOutlets
    @IBOutlet weak var logoutButton: UIButton! {
        didSet {
            logoutButton.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var licenseTypeLabel: UILabel!
    @IBOutlet weak var aircraftsTextView: UITextView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ConfirmationViewModel()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Functions
    private func setupViews() {
        welcomeLabel.text = "Welcome \(userName)"
        licenseTypeLabel.text = "Your License type is: \(licenseType.uppercased())"
        
        aircraftsTextView.text = String(format:"%@", aircrafts)
        adjustUITextViewHeight(aircraftsTextView)
    }
    
    func adjustUITextViewHeight(_ textView : UITextView) {
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.sizeToFit()
        textView.isScrollEnabled = false
    }

    @IBAction func logoutButtonTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
