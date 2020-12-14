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
        
        VStack (alignment: .leading) {
            DatePicker(selection: $date, in: ...Date(), displayedComponents: .date){
                Text("Filter by date:")
            }
            .onChange(of: $date.wrappedValue, perform: { value in
                dateChanged = true;
                someFilterChanged = true;
                
            })
            .frame(alignment: .center)
            Toggle(isOn: $filterByFavorite) {
                Text("Filter by Favorite")
            }.onChange(of: $filterByFavorite.wrappedValue, perform: { value in
                someFilterChanged = true
            })
            .frame(alignment: .center)
        }
        .padding(20)
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
