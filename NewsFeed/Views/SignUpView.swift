//
//  SignUpView.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 06/12/20.
//

import Foundation
import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel: SignUpViewModel
    @EnvironmentObject var loginController: LoginController
    
    var body: some View {
        if(loginController.getToken() == nil) {
            Text("SignUp, please")
            Button(action: {viewModel.signUp(loginController: loginController)}, label: {
                Text("Button")
            })
        } else {
            viewModel.viewForSignUpSuccess()
        }
    }
}
