//
//  NewsModelView.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 02/12/20.
//

import Foundation
import UIKit

class ContentViewModel: ObservableObject {

    @Published var news: [New];
    
    @Published var headlines: [New];
    
    let newsApiCommucication = NewsAPICommunication();
    
    let viewForSelectedNew: (New) -> NewDetailView;
    
    let viewForHighlightCell: (New) -> HeadlineCellView;
    let viewForNewCell: (New) -> NewCellView;
    
    @Published var isLoadingNewsListView: Bool = false;
    var currentPageNewsList = 1;
    var currentPageNewsWithFiltersList = 1;
    var perPageNewsList = 10;
    @Published var titleFilter: String = "";
    @Published var dateFilter: Date = Date();
    
    let firebaseFavoriteNewsService = FirebaseFavoriteNewsService()
    
    init(news: [New], headlines: [New], viewForSelectedNew: @escaping (New) -> NewDetailView, viewForHighlightCell: @escaping (New) -> HeadlineCellView, viewForNewCell: @escaping (New) -> NewCellView) {
        self.news = news;
        self.headlines = headlines;
        self.viewForSelectedNew = viewForSelectedNew;
        self.viewForHighlightCell = viewForHighlightCell;
        self.viewForNewCell = viewForNewCell;
    }
    
    func fetchHeadlines(loginController: LoginController) {
        newsApiCommucication.fetchHeadlines(loginController: loginController) { (response, err) in
            if err == nil {
                if let unwrapedResponse = response {
                    if let data = unwrapedResponse["data"] as? Array<Any> {
                        for element in data {
                            if let tempNew = element as? [String: Any] {
                                var decodedNew = self.personalizedDecoderForNewOrHighlight(newOrHighlight: tempNew)
                                self.newsApiCommucication.fetchNewsImage(url: decodedNew.image_url) { (image, err) in
                                    if err == nil {
                                        if let unwrapedImage = image {
                                            decodedNew.image = unwrapedImage
                                            self.headlines.append(decodedNew)
                                        } else {
                                            self.headlines.append(decodedNew)
                                        }
                                    } else {
                                        print("Failed to download news image. Error: \(String(describing: err))")
                                        self.news.append(decodedNew)
                                    }
                                }
                            }
                        }
                        //print(self.headlines)
                    }
                } else {
                    //No responses
                    print("No responses")
                }
            }
            
        }
    }
    
    func fetchNews(loginController: LoginController, isFirstReload: Bool) {
        self.isLoadingNewsListView = true;
        if isFirstReload {
            self.news = []
            self.currentPageNewsList = 1
            self.currentPageNewsWithFiltersList = 1
        }
        newsApiCommucication.fetchNews(currentPage: self.currentPageNewsList, perPage: self.perPageNewsList, loginController: loginController) { (response, err) in
            if err == nil {
                if let unwrapedResponse = response {
                    if let data = unwrapedResponse["data"] as? Array<Any> {
                        for element in data {
                            if let tempNew = element as? [String: Any] {
                                var decodedNew = self.personalizedDecoderForNewOrHighlight(newOrHighlight: tempNew)
                                self.newsApiCommucication.fetchNewsImage(url: decodedNew.image_url) { (image, err) in
                                    if err == nil {
                                        if let unwrapedImage = image {
                                            decodedNew.image = unwrapedImage
                                            self.news.append(decodedNew)
                                        } else {
                                            self.news.append(decodedNew)
                                        }
                                    } else {
                                        print("Failed to download news image. Error: \(String(describing: err))")
                                        self.news.append(decodedNew)
                                    }
                                }
                            }
                        }
                        //print(self.news)
                        self.currentPageNewsList += 1
                        self.isLoadingNewsListView = false
                    } else {
                        print("No responses")
                        self.isLoadingNewsListView = false
                    }
                } else {
                    //No responses
                    print("No responses")
                    self.isLoadingNewsListView = false
                }
            } else {
                print("No responses")
                self.isLoadingNewsListView = false
            }
        }
    }
    
    func fetchNewsWithFilters(includesDateFilter: Bool, filterByFavorite: Bool, loginController: LoginController, isFirstReload: Bool) {
        if isFirstReload {
            self.news = []
            self.currentPageNewsList = 1
            self.currentPageNewsWithFiltersList = 1
        }
        if includesDateFilter && !filterByFavorite {
            newsApiCommucication.fetchNewsWithFilters(currentPage: self.currentPageNewsWithFiltersList, perPage: self.perPageNewsList, loginController: loginController, date: self.dateFilter) { (response, err) in
                print("HERE")
                if err == nil {
                    if let unwrapedResponse = response {
                        if let data = unwrapedResponse["data"] as? Array<Any> {
                            for element in data {
                                if let tempNew = element as? [String: Any] {
                                    var decodedNew = self.personalizedDecoderForNewOrHighlight(newOrHighlight: tempNew)
                                    self.newsApiCommucication.fetchNewsImage(url: decodedNew.image_url) { (image, err) in
                                        if err == nil {
                                            if let unwrapedImage = image {
                                                decodedNew.image = unwrapedImage
                                                self.news.append(decodedNew)
                                            } else {
                                                print("Failed to download news image")
                                                self.news.append(decodedNew)
                                            }
                                        } else {
                                            print("Failed to download news image. Error: \(String(describing: err))")
                                            self.news.append(decodedNew)
                                        }
                                    }
                                }
                            }
                            //print(self.news)
                            self.currentPageNewsList += 1
                            self.isLoadingNewsListView = false
                        } else {
                            print("No responses")
                            self.isLoadingNewsListView = false
                        }
                    } else {
                        //No responses
                        print("No responses")
                        self.isLoadingNewsListView = false
                    }
                } else {
                    print("No responses")
                    self.isLoadingNewsListView = false
                }
            }
        } else if !includesDateFilter && filterByFavorite {
            firebaseFavoriteNewsService.getFavorites { (response, err) in
                if let error = err {
                    print("Error getting favorites: \(error)")
                } else {
                    if let favorites = response {
                        for favorite in favorites {
                            var decodedNew = self.personalizedDecoderForNewOrHighlight(newOrHighlight: favorite)
                            self.newsApiCommucication.fetchNewsImage(url: decodedNew.image_url) { (image, err) in
                                if err == nil {
                                    if let unwrapedImage = image {
                                        decodedNew.image = unwrapedImage
                                        self.news.append(decodedNew)
                                    } else {
                                        self.news.append(decodedNew)
                                    }
                                } else {
                                    print("Failed to download news image. Error: \(String(describing: err))")
                                    self.news.append(decodedNew)
                                }
                            }
                        }
                    } else {
                        print("Favorites response is not unwrapping.")
                    }
                }
            }
        } else if includesDateFilter && filterByFavorite {
            firebaseFavoriteNewsService.getFavoritesFromDate(date: self.dateFilter) { (response, err) in
                if let error = err {
                    print("Error getting favorites: \(error)")
                } else {
                    if let favorites = response {
                        for favorite in favorites {
                            var decodedNew = self.personalizedDecoderForNewOrHighlight(newOrHighlight: favorite)
                            self.newsApiCommucication.fetchNewsImage(url: decodedNew.image_url) { (image, err) in
                                if err == nil {
                                    if let unwrapedImage = image {
                                        decodedNew.image = unwrapedImage
                                        self.news.append(decodedNew)
                                    } else {
                                        self.news.append(decodedNew)
                                    }
                                } else {
                                    print("Failed to download news image. Error: \(String(describing: err))")
                                    self.news.append(decodedNew)
                                }
                            }
                        }
                    } else {
                        print("Favorites response is not unwrapping.")
                    }
                }
            }
        } else {
            // If this code is executed, that means someone is trying to run the function without passing any filters in the view. Make shure to fix that logic. Running fetchNews instead.
            print("Someone is trying to run the function without passing any filters in the view. Make shure to fix that logic. Running fetchNews instead")
            self.fetchNews(loginController: loginController, isFirstReload: isFirstReload)
        }
        print("filtering")
    }
    
    func personalizedDecoderForNewOrHighlight(newOrHighlight: [String: Any]) -> New {
        let title: String;
        let description: String;
        let content: String;
        let author: String;
        let publishedAt: Date;
        let highlight: Bool;
        let url: String;
        let image_url: String;
        
        if let tempTitle = newOrHighlight["title"] as? String {
            title = tempTitle
        } else {
            title = "New without title"
        }
        
        if let tempDescription = newOrHighlight["description"] as? String {
            description = tempDescription
        } else {
            description = "New without description"
        }
        
        if let tempContent = newOrHighlight["content"] as? String {
            content = tempContent
        } else {
            content = "New without description"
        }
        
        if let tempAuthor = newOrHighlight["author"] as? String {
            author = tempAuthor
        } else {
            author = "New without description"
        }
        
        if let tempPublishedAt = newOrHighlight["published_at"] as? String {
            
            //Trying to create a Date() object from a string in the followibg format
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
            
            let dateFormatterGet2 = DateFormatter()
            dateFormatterGet2.dateFormat = "yyyy-MM-dd"
            
            if let date = dateFormatterGet.date(from: tempPublishedAt) {
                //print(date)
                publishedAt = date
            } else if let date2 = dateFormatterGet2.date(from: tempPublishedAt) {
                publishedAt = date2
            } else {
                publishedAt = Date()
            }
        } else {
            //In the last case, if the date format is corrupted or different, asssing the current date
            publishedAt = Date()
        }
        
        if let tempHighlight = newOrHighlight["highlight"] as? Bool {
            highlight = tempHighlight
        } else {
            highlight = false
        }
        
        if let tempUrl = newOrHighlight["url"] as? String {
            url = tempUrl
        } else {
            url = "https://google.com"
        }
        
        if let tempImageUrl = newOrHighlight["image_url"] as? String {
            image_url = tempImageUrl
        } else {
            image_url = "https://google.com"
        }
        
        return New(title: title, description: description, content: content, author: author, publishedAt: publishedAt, highlight: highlight, url: url, image_url: image_url)
    }
    
}
