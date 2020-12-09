//
//  NewsFeedApp.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 02/12/20.
//

import SwiftUI

@main
struct NewsFeedApp: App {
    let persistenceController = PersistenceController.shared
    let viewModelFactory = ViewModelFactory()
    @StateObject var loginController = LoginController()

    var body: some Scene {
        WindowGroup {
            FirstView {
                //SignUpView(viewModel: viewModelFactory.makeSignUpViewModel())
                SignInView(viewModel: viewModelFactory.makeSignInViewModel())
            }.environmentObject(loginController)
        }
    }
}
