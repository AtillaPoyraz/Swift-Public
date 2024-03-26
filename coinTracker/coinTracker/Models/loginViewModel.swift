//
//  loginViewModel.swift
//  coinTracker
//
//  Created by Atilla Poyraz on 30.11.2023.
//

import Foundation
import FirebaseAuth

class LoginViewModel {

    var email: String?
    var password: String?

    func signIn(completion: @escaping (Bool, String?) -> Void) {
        guard let email = email, let password = password else {
            completion(false, "E-posta ve şifre gerekli.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion(false, "Giriş başarısız: \(error.localizedDescription)")
            } else {
                completion(true, nil)
            }
        }
    }
}
