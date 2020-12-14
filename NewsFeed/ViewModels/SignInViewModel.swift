//
//  SignInViewModel.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 06/12/20.
//

import Foundation
import SwiftUI

class SignInViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
    
    let viewForSignInSuccess: () -> ContentView;
    
    init(viewForSignInSuccess: @escaping () -> ContentView) {
        self.viewForSignInSuccess = viewForSignInSuccess;
    }
    
    func signIn(loginController: LoginController, email: String, password: String){
        self.isLoading = true
        loginController.signIn(email: email, password: password) { (response, err) in
            if let error = err {
                print("SignUp error: \(error)")
                self.showAlert = true
                self.alertTitle = "SignUp error"
                self.alertMessage = error.localizedDescription
                self.isLoading = false
            }
            self.isLoading = false
        }
    }
    
    func logout(loginController: LoginController){
        loginController.logout()
    }
    
}
