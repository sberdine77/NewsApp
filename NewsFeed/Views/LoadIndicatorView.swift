//
//  LoadIndicatorView.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 08/12/20.
//

import Foundation
import SwiftUI

struct LoadIndicatorView: View {
    var body: some View {
        Spinner(style: .medium)
                    .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}
