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
        if(loginController.getToken() == nil) {
            Text("SignIn, please")
            Button(action: {viewModel.signIn(loginController: loginController)}, label: {
                Text("Button")
            })
        } else {
            viewModel.viewForSignInSuccess()
        }
    }
}
