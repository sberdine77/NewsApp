//
//  FiltersView.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 08/12/20.
//

import Foundation
import SwiftUI

struct FiltersView: View {
    //@StateObject var viewModel: FiltersViewModel
    @Binding var title: String
    @Binding var date: Date
    @Binding var showFilterView: Bool;
    
    @Binding var dateChanged: Bool;
    @Binding var filterByFavorite: Bool;
    @Binding var someFilterChanged: Bool;

    var body: some View {
//        VStack (alignment: .center) {
//            Text("Filter by title:")
//            TextField("Enter new's title...", text: $title, onCommit:  {
//                if(($title.wrappedValue != "") && ($title.wrappedValue != " ")) {
//                    self.$titleChanged.wrappedValue = true;
//                    self.$someFilterChanged.wrappedValue = true;
//                }
//            })
//        }
//        .padding(.all, 20)
        
        VStack (alignment: .center) {
            Text("Filter by date:")
            DatePicker(selection: $date, in: ...Date(), displayedComponents: .date){
                Text("Date")
            }
            .onChange(of: $date.wrappedValue, perform: { value in
                self.$dateChanged.wrappedValue = true;
                self.$someFilterChanged.wrappedValue = true;
                
            })
            Toggle(isOn: $filterByFavorite) {
                Text("Filter by Favorite")
            }.onChange(of: $filterByFavorite.wrappedValue, perform: { value in
                self.$someFilterChanged.wrappedValue = true
            })
        }
        Button("Clear") {
            self.$title.wrappedValue = ""
            //self.$date.wrappedValue = Date()
            self.$dateChanged.wrappedValue = false
            self.$someFilterChanged.wrappedValue = true;
        }
        Button("Ok") {
            $showFilterView.wrappedValue = false
        }
    }
}
