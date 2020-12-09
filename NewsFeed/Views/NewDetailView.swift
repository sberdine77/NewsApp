//
//  NewDetailView.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 03/12/20.
//

import Foundation
import SwiftUI

struct NewDetailView: View {
    @StateObject var viewModel: NewDetailViewModel
    var body: some View {
        Text(viewModel.new.title)
    }
}
