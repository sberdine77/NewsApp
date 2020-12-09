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

    init(@ViewBuilder content: () -> SignInView) {
        self.content = content()
    }
    
    var body: some View {
        content
    }
}
