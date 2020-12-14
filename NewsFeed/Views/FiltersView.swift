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
                dateChanged = true;
                someFilterChanged = true;
                
            })
            Toggle(isOn: $filterByFavorite) {
                Text("Filter by Favorite")
            }.onChange(of: $filterByFavorite.wrappedValue, perform: { value in
                someFilterChanged = true
            })
        }
        Button("Clear") {
            //self.$date.wrappedValue = Date()
            filterByFavorite = false
            dateChanged = false
            someFilterChanged = true
            showFilterView = false
        }
        Button("Ok") {
            $showFilterView.wrappedValue = false
            print($showFilterView.wrappedValue)
        }
    }
}
