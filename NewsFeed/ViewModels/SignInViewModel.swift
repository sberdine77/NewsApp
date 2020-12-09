//
//  SignInViewModel.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 06/12/20.
//

import Foundation
import SwiftUI

class SignInViewModel: ObservableObject {
    let viewForSignInSuccess: () -> ContentView;
    
    init(viewForSignInSuccess: @escaping () -> ContentView) {
        self.viewForSignInSuccess = viewForSignInSuccess;
    }
    
    func signIn(loginController: LoginController){
        loginController.signIn(email: "savio1@savioteste.com", password: "12345678") { (response, err) in
            //
        }
    }
    
    func logout(loginController: LoginController){
        loginController.logout()
    }
    
}
