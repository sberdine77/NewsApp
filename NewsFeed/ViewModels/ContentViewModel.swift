//
//  NewsModelView.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 02/12/20.
//

import Foundation


class ContentViewModel: ObservableObject {
    
    @Published var news: [New];
    
    @Published var headlines: [New];
    
    let newsApiCommucication = NewsAPICommunication();
    
    let viewForSelectedNew: (New) -> NewDetailView;
    
    let viewForHighlightCell: (New) -> HeadlineCellView;
    let viewForNewCell: (New) -> NewCellView;
    
    @Published var isLoadingNewsListView: Bool = false;
    var currentPageNewsList = 1;
    var perPageNewsList = 10;
    @Published var titleFilter: String = "";
    @Published var dateFilter: Date = Date();
    
    init(news: [New], headlines: [New], viewForSelectedNew: @escaping (New) -> NewDetailView, viewForHighlightCell: @escaping (New) -> HeadlineCellView, viewForNewCell: @escaping (New) -> NewCellView) {
        self.news = news;
        self.headlines = headlines;
        self.viewForSelectedNew = viewForSelectedNew;
        self.viewForHighlightCell = viewForHighlightCell;
        self.viewForNewCell = viewForNewCell;
    }
    
    func fetchHeadlines(loginController: LoginController) {
        newsApiCommucication.fetchHeadlines(loginController: loginController) { (response, err) in
//            print("Highlights")
//            print("Response")
//            print(response ?? "none")
//            print("Error")
//            print(err ?? "none")
            if err == nil {
                if let unwrapedResponse = response {
                    if let data = unwrapedResponse["data"] as? Array<Any> {
                        for element in data {
                            if let tempNew = element as? [String: Any] {
                                let decoder = JSONDecoder()
                                do {
                                    let jsonData = try JSONSerialization.data (withJSONObject: tempNew, options: [])
                                    let decodedNew = try decoder.decode(New.self, from: jsonData)
                                    self.headlines.append(decodedNew)
                                } catch {
                                    print("Error directly decoding new. Using personalized decoder...")
                                    self.headlines.append(self.personalizedDecoderForNewOrHighlight(newOrHighlight: tempNew))
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
    
    func fetchNews(loginController: LoginController) {
        self.isLoadingNewsListView = true;
        newsApiCommucication.fetchNews(currentPage: self.currentPageNewsList, perPage: self.perPageNewsList, loginController: loginController) { (response, err) in
//            print("News")
//            print("Response")
//            print(response ?? "none")
//            print("Error")
//            print(err ?? "none")
            if err == nil {
                if let unwrapedResponse = response {
                    if let data = unwrapedResponse["data"] as? Array<Any> {
                        for element in data {
                            if let tempNew = element as? [String: Any] {
                                let decoder = JSONDecoder()
                                do {
                                    let jsonData = try JSONSerialization.data (withJSONObject: tempNew, options: [])
                                    let decodedNew = try decoder.decode(New.self, from: jsonData)
                                    self.news.append(decodedNew)
                                } catch {
                                    print("Error directly decoding new. Using personalized decoder...")
                                    self.news.append(self.personalizedDecoderForNewOrHighlight(newOrHighlight: tempNew))
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
    
    func fetchNewsWithFilters(includesDateFilter: Bool, loginController: LoginController) {
        if includesDateFilter {
            newsApiCommucication.fetchNewsWithFilters(currentPage: self.currentPageNewsList, perPage: self.perPageNewsList, loginController: loginController, title: self.titleFilter, date: self.dateFilter) { (response, err) in
    //            print("News")
    //            print("Response")
    //            print(response ?? "none")
    //            print("Error")
    //            print(err ?? "none")
                if err == nil {
                    if let unwrapedResponse = response {
                        if let data = unwrapedResponse["data"] as? Array<Any> {
                            for element in data {
                                if let tempNew = element as? [String: Any] {
                                    let decoder = JSONDecoder()
                                    do {
                                        let jsonData = try JSONSerialization.data (withJSONObject: tempNew, options: [])
                                        let decodedNew = try decoder.decode(New.self, from: jsonData)
                                        self.news.append(decodedNew)
                                    } catch {
                                        print("Error directly decoding new. Using personalized decoder...")
                                        self.news.append(self.personalizedDecoderForNewOrHighlight(newOrHighlight: tempNew))
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
        } else {
            newsApiCommucication.fetchNewsWithFilters(currentPage: self.currentPageNewsList, perPage: self.perPageNewsList, loginController: loginController, title: self.titleFilter, date: self.dateFilter) { (response, err) in
    //            print("News")
    //            print("Response")
    //            print(response ?? "none")
    //            print("Error")
    //            print(err ?? "none")
                if err == nil {
                    if let unwrapedResponse = response {
                        if let data = unwrapedResponse["data"] as? Array<Any> {
                            for element in data {
                                if let tempNew = element as? [String: Any] {
                                    let decoder = JSONDecoder()
                                    do {
                                        let jsonData = try JSONSerialization.data (withJSONObject: tempNew, options: [])
                                        let decodedNew = try decoder.decode(New.self, from: jsonData)
                                        self.news.append(decodedNew)
                                    } catch {
                                        print("Error directly decoding new. Using personalized decoder...")
                                        self.news.append(self.personalizedDecoderForNewOrHighlight(newOrHighlight: tempNew))
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
            print(tempPublishedAt)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .init(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: tempPublishedAt) {
                //print(date)
                publishedAt = date
            } else {
                publishedAt = Date()
            }
        } else {
            
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
        
        if let tempImageUrl = newOrHighlight["url"] as? String {
            image_url = tempImageUrl
        } else {
            image_url = "https://google.com"
        }
        
        return New(title: title, description: description, content: content, author: author, publishedAt: publishedAt, highlight: highlight, url: url, image_url: image_url)
    }
    
}
