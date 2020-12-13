//
//  ContentView.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 02/12/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //@Environment(\.managedObjectContext) private var viewContext
    @StateObject var viewModel: ContentViewModel
    @EnvironmentObject var loginController: LoginController
    
    @State var showFilterView: Bool = false;
    @State var dateFilterActivated: Bool = false;
    @State var someFilterChanged: Bool = false;
    
    var body: some View {
        NavigationView {
            List {
                VStack (alignment: .leading) {
                    Text("Headlines")
                        .font(.title2)
                        .padding(.bottom, 10)
                    ScrollView (.horizontal){
                        VStack (alignment: .leading) {
                            HStack (alignment: .top, spacing: 25) {
                                ForEach(viewModel.headlines, id: \.id) { oneNew in
                                    NavigationLink(destination: viewModel.viewForSelectedNew(oneNew)) {
                                        viewModel.viewForHighlightCell(oneNew)
                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }
                        }.padding(.bottom, 20)
                    }
                    .frame(width: nil, height: 210, alignment: .leading)
                }
                HStack {
                    NavigationLink(destination: FiltersView(title: $viewModel.titleFilter, date: $viewModel.dateFilter, showFilterView: self.$showFilterView, dateChanged: self.$dateFilterActivated, someFilterChanged: self.$someFilterChanged).onDisappear(perform: {self.performFilters()}), isActive: self.$showFilterView) {
                        HStack {
                            Text("Your News")
                                .font(.title2)
                            Spacer()
                            Text("Filters")
                        }
                    }
                }
                .padding(.bottom, 15)
                ForEach(viewModel.news, id: \.id) { oneNew in
                    HStack {
                        viewModel.viewForNewCell(oneNew)
                            //.padding(.bottom, 10)
                            .onAppear(perform:{
                                if ((viewModel.news.last == oneNew) && (viewModel.isLoadingNewsListView == false)) {
                                    //If more filters are activated, add the booblean controller in this conditional
                                    if((self.dateFilterActivated)) {
                                        viewModel.fetchNewsWithFilters(includesDateFilter: dateFilterActivated, loginController: loginController, isFirstReload: false)
                                    } else {
                                        viewModel.fetchNews(loginController: loginController, isFirstReload: false)
                                    }
                                }
                            })
                        NavigationLink(destination: viewModel.viewForSelectedNew(oneNew)) {
                            EmptyView()
                        }
                        .frame(width: 0)
                        .opacity(0)
                    }
                }
                
                if viewModel.isLoadingNewsListView {
                    LoadIndicatorView()
                }
            }
            .navigationBarTitle(Text("News App"))
            .navigationBarItems(trailing:
                Button("Logout") {
                    loginController.logout()
                }
            )
        }
        .onAppear(perform: {
            viewModel.fetchHeadlines(loginController: loginController)
            viewModel.fetchNews(loginController: loginController, isFirstReload: true)
        })
    }
    
    func performFilters() {
        //Checking if the filters were cleared or if there's a filter activated
        //Change this conditional if more filters are added in the future
        if self.someFilterChanged && self.dateFilterActivated {
            viewModel.fetchNewsWithFilters(includesDateFilter: dateFilterActivated, loginController: loginController, isFirstReload: true)
            self.someFilterChanged = false
        } else if self.someFilterChanged && !self.dateFilterActivated {
            viewModel.fetchNews(loginController: loginController, isFirstReload: true)
            self.someFilterChanged = false
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(viewModel: ContentViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
