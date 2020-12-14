//
//  FirstView.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 07/12/20.
//

import Foundation

import Foundation
import SwiftUI

struct FirstView: View {
    
    @State var isSignUp: Bool = false
    
    let viewModelFactory: ViewModelFactory
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var loginController: LoginController
    
    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }
    
    var body: some View {
        if isSignUp {
            SignUpView(viewModel: viewModelFactory.makeSignUpViewModel(), isSignUp: self.$isSignUp)
                .onAppear(perform: {
                    loginController.context = managedObjectContext
                    loginController.fetchToken()
                })
        } else {
            SignInView(viewModel: viewModelFactory.makeSignInViewModel(), isSignUp: self.$isSignUp)
                .onAppear(perform: {
                    loginController.context = managedObjectContext
                    loginController.fetchToken()
                })
        }
    }
}
