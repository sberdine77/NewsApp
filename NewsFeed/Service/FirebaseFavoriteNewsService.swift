//
//  FirebaseFavoriteNewsService.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 13/12/20.
//

import Foundation
import FirebaseFirestore
import Firebase

class FirebaseFavoriteNewsService {
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var favListener: ListenerRegistration?

    
    func addFavorite(favorite: [String: Any], completionHandler: @escaping (_ response: String?, _ error: Error?) -> Void) {
        let currentUser = Auth.auth().currentUser
        if let user = currentUser {
            ref = db.collection("users").document(user.uid).collection("favorites").addDocument(data: favorite, completion: { (err) in
                if let error = err {
                    completionHandler(nil, error)
                } else {
                    completionHandler("Success adding favorite", nil)
                }
            })
        } else {
            let error = NewsRequestError(message: "User not loged in")
            completionHandler(nil, error)
        }
        
    }
    
    func removeFavorite(title: String, completionHandler: @escaping (_ response: String?, _ error: Error?) -> Void) {
        let currentUser = Auth.auth().currentUser
        if let user = currentUser {
            db.collection("users").document(user.uid).collection("favorites").whereField("title", isEqualTo: title).getDocuments() { (querySnapshot, err) in
                if let error = err {
                    completionHandler(nil, error)
                } else {
                    if let snapshot = querySnapshot {
                        if snapshot.documents.count > 0 {
                            let tempRef = snapshot.documents[0].documentID
                            print(tempRef)
                            self.db.collection("users").document(user.uid).collection("favorites").document(tempRef).delete() { err in
                                if let error = err {
                                    let error = NewsRequestError(message: "Favorite not removed. Error \(error)")
                                    completionHandler(nil, error)
                                } else {
                                    completionHandler("Success! Favorite removed.", nil)
                                }
                            }
                        } else {
                            let error = NewsRequestError(message: "Favorite not found.")
                            completionHandler(nil, error)
                        }
                    } else {
                        let error = NewsRequestError(message: "Favorites query was not successful.")
                        completionHandler(nil, error)
                    }
                }
            }
        } else {
            let error = NewsRequestError(message: "User not loged in")
            completionHandler(nil, error)
        }
    }
    
    func isFavorite(title: String, completionHandler: @escaping (_ response: Bool?, _ error: Error?) -> Void) {
        let currentUser = Auth.auth().currentUser
        if let user = currentUser {
            db.collection("users").document(user.uid).collection("favorites").whereField("title", isEqualTo: title).addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    let error = NewsRequestError(message: "Favorites query was not successful.")
                    completionHandler(nil, error)
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        completionHandler(true, nil)
                    }
//                    if (diff.type == .modified) {
//                        print("Modified city: \(diff.document.data())")
//                    }
                    if (diff.type == .removed) {
                        completionHandler(false, nil)
                    }
                }
            }
        } else {
            let error = NewsRequestError(message: "User not loged in")
            completionHandler(nil, error)
        }
    }
    
    func getFavorites(completionHandler: @escaping (_ response: [[String: Any]]?, _ error: Error?) -> Void) {
        let currentUser = Auth.auth().currentUser
        if let user = currentUser {
            db.collection("users").document(user.uid).collection("favorites").getDocuments() { (querySnapshot, err) in
                if let error = err {
                    completionHandler(nil, error)
                } else {
                    if let snapshot = querySnapshot {
                        var favoritesArray: [[String: Any]] = []
                        for element in snapshot.documents {
                            favoritesArray.append(element.data())
                        }
                        completionHandler(favoritesArray, nil)
                    } else {
                        let error = NewsRequestError(message: "Favorites query was not successful.")
                        completionHandler(nil, error)
                    }
                }
            }
        } else {
            let error = NewsRequestError(message: "User not loged in")
            completionHandler(nil, error)
        }
    }
    
    func getFavoritesFromDate(date: Date, completionHandler: @escaping (_ response: [[String: Any]]?, _ error: Error?) -> Void) {
        let currentUser = Auth.auth().currentUser
        if let user = currentUser {
            
            let dateFormatter = DateFormatter()
            let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
            dateFormatter.locale = enUSPosixLocale
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let createdDate = dateFormatter.string(from: date)
            
            db.collection("users").document(user.uid).collection("favorites").whereField("published_at", isEqualTo: createdDate).getDocuments() { (querySnapshot, err) in
                if let error = err {
                    completionHandler(nil, error)
                } else {
                    if let snapshot = querySnapshot {
                        var favoritesArray: [[String: Any]] = []
                        for element in snapshot.documents {
                            favoritesArray.append(element.data())
                        }
                        completionHandler(favoritesArray, nil)
                    } else {
                        let error = NewsRequestError(message: "Favorites query was not successful.")
                        completionHandler(nil, error)
                    }
                }
            }
        } else {
            let error = NewsRequestError(message: "User not loged in")
            completionHandler(nil, error)
        }
    }
    
}
