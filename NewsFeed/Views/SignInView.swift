//
//  SignInView.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 06/12/20.
//

import Foundation
import SwiftUI

struct SignInView: View {
    @StateObject var viewModel: SignInViewModel
    @EnvironmentObject var loginController: LoginController

    var body: some View {
        VStack {
            if(loginController.getToken() == nil) {
                Text("SignIn, please")
                Button(action: {viewModel.signIn(loginController: loginController)}, label: {
                    Text("Button")
                })
                FacebookLoginButtonView(loginController: loginController)
                    .frame(width: 200, height: 50)
                
            } else {
                viewModel.viewForSignInSuccess()
            }
        }.alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
}
