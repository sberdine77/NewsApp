//
//  Spinner.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 08/12/20.
//

import Foundation
import SwiftUI

struct Spinner: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}
