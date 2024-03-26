//
//  RegisterViewController.swift
//  coinTracker
//
//  Created by Atilla Poyraz on 30.11.2023.
//


import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    var viewModel = RegisterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func registerButtonTapped(_ sender: Any) {
        viewModel.email = emailTextField.text
        viewModel.password = passwordTextField.text
        viewModel.confirmPassword = confirmPasswordTextField.text

        viewModel.register { success, message in
            if success {
                print("Kayıt başarılı!")
                self.showAlert(title: "Başarılı", message: message ?? "Kayıt başarıyla tamamlandı.")
                // Kayıt başarılıysa bir sonraki ekrana geçiş yapabilirsiniz.
                self.navigationController?.popViewController(animated: true)
            } else {
                print("Kayıt başarısız: \(message ?? "")")
                self.showAlert(title: "Hata", message: message ?? "Bir hata oluştu.")
            }
        }
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
