//
//  LoginViewController.swift
//  coinTracker
//
//  Created by Atilla Poyraz on 30.11.2023.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!

    var viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        viewModel.email = emailTextField.text
        viewModel.password = passwordTextField.text

        viewModel.signIn { success, message in
            if success {
                print("Giriş başarılı!")
                // Giriş başarılıysa bir sonraki ekrana geçiş yapabilirsiniz.
                
            } else {
                print("Giriş başarısız: \(message ?? "")")
                self.showAlert(title: "Hata", message: message ?? "Bir hata oluştu.")
            }
        }
    }

    @IBAction func goToRegisterViewController(_ sender: Any) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
   
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    @objc func togglePasswordVisibility() {
        // Şifreyi gösterme veya gizleme
        passwordTextField.isSecureTextEntry.toggle()

        // Buton resmini değiştirme
        let buttonImageName = passwordTextField.isSecureTextEntry ? "view" : "hide"
        showPasswordButton.setImage(UIImage(named: buttonImageName), for: .normal)
    }
}
