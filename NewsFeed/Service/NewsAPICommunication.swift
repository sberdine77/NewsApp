//
//  NewsAPICommunication.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 02/12/20.
//

import Foundation
import Alamofire

class NewsAPICommunication {
    private let baseUrl = "https://mesa-news-api.herokuapp.com/"
    
    func fetchHeadlines(loginController: LoginController, completionHandler: @escaping (_ response: [String: Any]?, _ error: Error?) -> Void) {
        if let token = loginController.getToken() {
            let headers: HTTPHeaders = [.accept("application/json"), .authorization(bearerToken: token)]
            AF.request("\(baseUrl)v1/client/news/highlights", method: .get, headers: headers).responseJSON { (response) in
                print(response)
                switch response.result {
                case .success(let JSON):
                    if let responseSuccess = JSON as? [String: Any] {
                        completionHandler(responseSuccess, nil)
                    }
                case .failure(let error):
                    completionHandler(nil, error)
                }
            }
        } else {
            let err = NewsRequestError(message: "Invalid token. Please, logout and login again.")
            completionHandler(nil, err)
        }
        
    }
    
    func fetchNews(currentPage: Int, perPage: Int, loginController: LoginController, completionHandler: @escaping (_ response: [String: Any]?, _ error: Error?) -> Void) {
        if let token = loginController.getToken() {
            let headers: HTTPHeaders = [.accept("application/json"), .authorization(bearerToken: token)]
            AF.request("\(baseUrl)v1/client/news?current_page=\(currentPage)&per_page=\(perPage)", method: .get, headers: headers).responseJSON { (response) in
                print(response)
                switch response.result {
                case .success(let JSON):
                    if let responseSuccess = JSON as? [String: Any] {
                        completionHandler(responseSuccess, nil)
                    }
                case .failure(let error):
                    completionHandler(nil, error)
                }
            }
        } else {
            let err = NewsRequestError(message: "Invalid token. Please, logout and login again.")
            completionHandler(nil, err)
        }

    }
    
    func fetchNewsWithFilters(currentPage: Int, perPage: Int, loginController: LoginController, title: String = "", date: Date?, completionHandler: @escaping (_ response: [String: Any]?, _ error: Error?) -> Void) {
        if let token = loginController.getToken() {
            let headers: HTTPHeaders = [.accept("application/json"), .authorization(bearerToken: token)]
            
            //Format the date to "yyy-mm-dd" so the query only go as further as the day
            let dateFormatter = DateFormatter()
            let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
            dateFormatter.locale = enUSPosixLocale
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let createdDate = dateFormatter.string(from: date ?? Date())
            
            AF.request("\(baseUrl)v1/client/news?current_page=1&per_page=\(perPage)&published_at=\(createdDate)T00:00:00.000Z", method: .get, headers: headers).responseJSON { (response) in
                print(response)
                switch response.result {
                case .success(let JSON):
                    if let responseSuccess = JSON as? [String: Any] {
                        completionHandler(responseSuccess, nil)
                    }
                case .failure(let error):
                    completionHandler(nil, error)
                }
            }
        } else {
            let err = NewsRequestError(message: "Invalid token. Please, logout and login again.")
            completionHandler(nil, err)
        }

    }
}
