//
//  SignUpViewModel.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 06/12/20.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    
    let viewForSignUpSuccess: () -> ContentView;
    
    init(viewForSignUpSuccess: @escaping () -> ContentView) {
        self.viewForSignUpSuccess = viewForSignUpSuccess;
    }
    
    func signUp(loginController: LoginController){
        loginController.signUp(name: "Sávio Berdine", email: "savio5@savioteste.com", password: "12345678") { (response, err) in
            //
        }
    }
    
    func logout(loginController: LoginController){
        loginController.logout()
    }
    
}
