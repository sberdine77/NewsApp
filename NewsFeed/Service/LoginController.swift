//
//  LoginController.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 06/12/20.
//

import Foundation
import Alamofire

class LoginController: ObservableObject {
    @Published private var token: String?
    private let baseUrl = "https://mesa-news-api.herokuapp.com/"
    
    func getToken() -> String? {
        return token;
    }
    
    func logout() {
        self.token = nil;
    }
    
    func signUp(name: String, email: String, password: String, completionHandler: @escaping (_ response: String?, _ error: Error?) -> Void) {
        let parameters = ["name": name, "email": email, "password": password]
        let headers: HTTPHeaders = [.accept("application/json")]
        
        AF.request("\(baseUrl)v1/client/auth/signup", method: .post, parameters: parameters, headers: headers).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let JSON):
                if let responseSuccess = JSON as? [String: Any] {
                    if let tokenResponse = responseSuccess["token"] as? String {
                        self.token = tokenResponse
                        completionHandler("Success", nil)
                    } else {
                        if let errorArray = responseSuccess["errors"] as? Array<Any> {
                            if let errorDictionary = errorArray[0] as? [String: Any] {
                                if let errorMessage = errorDictionary["message"] as? String {
                                    let err = LoginError(message: errorMessage)
                                    completionHandler(nil, err)
                                } else {
                                    let err = LoginError(message: "Uknown error. Please, try again later.")
                                    completionHandler(nil, err)
                                }
                            }
                        }
                    }
                } else {
                    let err = LoginError(message: "Uknown error. Please, try again later.")
                    completionHandler(nil, err)
                }
                break
            case .failure(let error):
                print(error)
                completionHandler(nil, error)
            }
        })
    }
    
    func signIn(email: String, password: String, completionHandler: @escaping (_ response: String?, _ error: Error?) -> Void) {
        let parameters = ["email": email, "password": password]
        let headers: HTTPHeaders = [.accept("application/json")]
        
        AF.request("\(baseUrl)v1/client/auth/signin", method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                if let responseSuccess = JSON as? [String: Any] {
                    if let tokenResponse = responseSuccess["token"] as? String {
                        self.token = tokenResponse
                        completionHandler("Success", nil)
                    } else {
                        if let errorMessage = responseSuccess["message"] as? String {
                            let err = LoginError(message: errorMessage)
                            completionHandler(nil, err)
                        } else {
                            let err = LoginError(message: "Uknown error. Please, try again later.")
                            completionHandler(nil, err)
                        }
                    }
                } else {
                    let err = LoginError(message: "Uknown error. Please, try again later.")
                    completionHandler(nil, err)
                }
                break
            case .failure(let error):
                print(error)
                completionHandler(nil, error)
            }
        }
    }
}
