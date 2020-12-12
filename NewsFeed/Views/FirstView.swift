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
    let content: SignInView
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var loginController: LoginController
    
    init(@ViewBuilder content: () -> SignInView) {
        self.content = content()
    }
    
    var body: some View {
        content
            .onAppear(perform: {
                loginController.context = managedObjectContext
                loginController.fetchToken()
            })
    }
}
