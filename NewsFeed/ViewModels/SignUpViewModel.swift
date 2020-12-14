//
//  SignUpViewModel.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 06/12/20.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    let viewForSignUpSuccess: () -> ContentView;
    
    init(viewForSignUpSuccess: @escaping () -> ContentView) {
        self.viewForSignUpSuccess = viewForSignUpSuccess;
    }
    
    func signUp(loginController: LoginController, name: String, email: String, password: String){
        loginController.signUp(name: name, email: email, password: password) { (response, err) in
            if let error = err {
                print("SignUp error: \(error)")
                self.showAlert = true
                self.alertTitle = "SignUp error"
                self.alertMessage = error.localizedDescription
            }
        }
    }
    
    func logout(loginController: LoginController){
        loginController.logout()
    }
    
}
