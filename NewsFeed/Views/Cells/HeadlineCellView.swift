//
//  HeadlineCellView.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 03/12/20.
//

import Foundation
import SwiftUI

struct HeadlineCellView: View {
    @StateObject var viewModel: HeadlineCellViewModel
    var body: some View {
        VStack (alignment: .leading) {
            Image(uiImage: viewModel.new.image)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 200, maxHeight: 100, alignment: .center)
                .cornerRadius(5)
            HStack (alignment: .top) {
                Text(viewModel.new.title)
                    .accentColor(.primary)
                    .frame(alignment: .leading)
                    .font(.headline)
                    .lineLimit(2)
                Spacer()
                Button(action: {viewModel.favorite()}, label: {
                        if(viewModel.isFavorite) {
                            Image("favorite_full_icon")
                                .resizable()
                        } else {
                            Image("favorite_empty_icon")
                                .resizable()
                        }
                })
                .frame(width: 20, height: 20, alignment: .leading)
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(Color.accentColor)
                
            }
            Text(viewModel.new.description)
                .accentColor(.primary)
                .lineLimit(2)
                .frame(width: 180)
        }
        .frame(maxWidth: 200)
        .padding(.leading, 0)
        .padding(.trailing, 0)
    }
}
