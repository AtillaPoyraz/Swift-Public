//
//  registerViewModel.swift
//  coinTracker
//
//  Created by Atilla Poyraz on 30.11.2023.
//

import Foundation
import FirebaseAuth

class RegisterViewModel {

    var email: String?
    var password: String?
    var confirmPassword: String?

    func register(completion: @escaping (Bool, String?) -> Void) {
        guard let email = email, let password = password, let confirmPassword = confirmPassword else {
            completion(false, "E-posta, şifre ve onay şifresi gerekli.")
            return
        }

        if password != confirmPassword {
            completion(false, "Şifreler eşleşmiyor.")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion(false, "Kayıt başarısız: \(error.localizedDescription)")
            } else {
                completion(true, "Kayıt başarılı!")
            }
        }
    }
}
