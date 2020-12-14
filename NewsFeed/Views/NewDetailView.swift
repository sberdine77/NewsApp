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
        Image(uiImage: viewModel.new.image)
            .renderingMode(.original)
            .resizable()
            .scaledToFill()
            .frame(height: 300)
            .frame(maxWidth: .infinity,alignment: .top)
            .clipped()
        VStack (alignment: .leading) {
            Text(viewModel.new.title)
                .padding(.trailing, 20)
                .padding(.leading, 20)
                .padding(.top, 10)
                .font(.title)
            if let destination = URL(string: viewModel.new.url) {
                Link("Visit the news website", destination: destination)
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
                    .padding(.top, 10)
            }
            Text(viewModel.new.content)
                .padding(.trailing, 20)
                .padding(.leading, 20)
                .padding(.top, 10)
                .lineLimit(5)
        }
        Spacer()
    }
}
