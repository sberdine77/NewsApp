//
//  FacebookLoginButtonView.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 14/12/20.
//

import Foundation
import SwiftUI
import UIKit
import FirebaseAuth
import Firebase
import FBSDKLoginKit
import Alamofire

struct FacebookLoginButtonView: UIViewRepresentable {
    
    var loginController: LoginController
    
    init (loginController: LoginController) {
        self.loginController = loginController
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIView(context: UIViewRepresentableContext<FacebookLoginButtonView>) -> FBLoginButton {
        let button = FBLoginButton()
        button.permissions = ["public_profile", "email"]
        button.delegate = self.loginController
        return button
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<FacebookLoginButtonView>) {
        if loginController.getToken() == nil {
            self.loginController.loginButtonDidLogOut(uiView)
        }
    }

}

//struct FacebookLoginButtonView: UIViewRepresentable {
//    func makeUIView(context: UIViewRepresentableContext<FacebookLoginButtonView>) -> GIDSignInButton {
//
//        let button = button.colorScheme = .dark
//        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
//        return button
//    }
//
//    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<GoogleSignIn>) {
//
//    }
//
//
//}

