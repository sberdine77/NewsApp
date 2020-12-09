//
//  NewCellView.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 03/12/20.
//

import Foundation
import SwiftUI

struct NewCellView: View {
    @StateObject var viewModel: NewCellViewModel
    //@State var favoriteButtonTaped: Bool = false;
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            VStack (alignment: .leading) {
                HStack (alignment: .top) {
                    Text(viewModel.new.title)
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
                .frame(maxWidth: .infinity)
                .padding(.leading, 0)
                .padding(.trailing, 0)
                Text(viewModel.new.publishedAt.description)
                    .font(.subheadline)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 0)
            .padding(.trailing, 0)
            Text(viewModel.new.description)
                .lineLimit(2)
                .padding(.top, 5)
            Image("newImage")
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 200)
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 0)
        .padding(.trailing, 0)
        .frame(height: 300)
        //.padding(.bottom, -10)
    }
}
