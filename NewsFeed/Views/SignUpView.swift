//
//  SignUpView.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 06/12/20.
//

import Foundation
import SwiftUI
import Firebase

struct SignUpView: View {
    @StateObject var viewModel: SignUpViewModel
    @EnvironmentObject var loginController: LoginController
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @Binding var isSignUp: Bool
    
    var body: some View {
        VStack {
            if Auth.auth().currentUser != nil {
                if(loginController.getToken() == nil) {
                    VStack (alignment: .leading) {
                        Text("Name:")
                        TextField("Enter your Name", text: $name)
                            .padding(.top, 10)
                    }
                    .padding(10)
                    
                    VStack (alignment: .leading) {
                        Text("E-mail:")
                        TextField("Enter your e-mail", text: $email)
                            .padding(.top, 10)
                    }
                    .padding(10)
                    
                    VStack (alignment: .leading) {
                        Text("Password:")
                        TextField("Enter your password", text: $password)
                            .padding(.top, 10)
                    }
                    .padding(10)
                    
                    VStack {
                        Button("SignUp") {
                            if (($email.wrappedValue == "") || ($password.wrappedValue == "") || ($name.wrappedValue == "")) {
                                viewModel.alertTitle = "Fail"
                                viewModel.alertMessage = "You left some field empty"
                                viewModel.showAlert = true
                            } else {
                                viewModel.signUp(loginController: loginController, name: $name.wrappedValue, email: $email.wrappedValue, password: $password.wrappedValue)
                            }
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 15)
                        FacebookLoginButtonView(loginController: loginController)
                            .frame(width: 200, height: 50)
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                    
                    VStack {
                        Text("Already have an account? Sign in!")
                        Button("Sign in") {
                            self.isSignUp = false
                        }
                    }
                    .padding(.bottom, 20)
                } else {
                    viewModel.viewForSignUpSuccess()
                }
            } else {
                VStack (alignment: .leading) {
                    Text("Name:")
                    TextField("Enter your Name", text: $name)
                        .padding(.top, 10)
                }
                .padding(10)
                
                VStack (alignment: .leading) {
                    Text("E-mail:")
                    TextField("Enter your e-mail", text: $email)
                        .padding(.top, 10)
                }
                .padding(10)
                
                VStack (alignment: .leading) {
                    Text("Password:")
                    TextField("Enter your password", text: $password)
                        .padding(.top, 10)
                }
                .padding(10)
                
                VStack {
                    Button("SignUp") {
                        if (($email.wrappedValue == "") || ($password.wrappedValue == "") || ($name.wrappedValue == "")) {
                            viewModel.alertTitle = "Fail"
                            viewModel.alertMessage = "You left some field empty"
                            viewModel.showAlert = true
                        } else {
                            viewModel.signUp(loginController: loginController, name: $name.wrappedValue, email: $email.wrappedValue, password: $password.wrappedValue)
                        }
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 15)
                    FacebookLoginButtonView(loginController: loginController)
                        .frame(width: 200, height: 50)
                }
                .padding(.top, 30)
                
                Spacer()
                
                VStack {
                    Text("Already have an account? Sign in!")
                    Button("Sign in") {
                        self.isSignUp = false
                    }
                }
                .padding(.bottom, 20)
            }
            
        }.alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
}
