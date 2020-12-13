//
//  FirebaseFavoriteNewsService.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 13/12/20.
//

import Foundation
import FirebaseFirestore

class FirebaseFavoriteNewsService {
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    
    func addFavorite(favorite: [String: Any], completionHandler: @escaping (_ response: String?, _ error: Error?) -> Void) {
        ref = db.collection("favorites").addDocument(data: favorite, completion: { (err) in
            if let error = err {
                completionHandler(nil, error)
            } else {
                completionHandler("Success adding favorite", nil)
            }
        })
    }
    
    func removeFavorite(title: String, completionHandler: @escaping (_ response: String?, _ error: Error?) -> Void) {
        
        db.collection("favorites").whereField("title", isEqualTo: title).getDocuments() { (querySnapshot, err) in
            if let error = err {
                completionHandler(nil, error)
            } else {
                if let snapshot = querySnapshot {
                    if snapshot.documents.count > 0 {
                        let tempRef = snapshot.documents[0].documentID
                        self.db.collection("favorites").document(tempRef).delete() { err in
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
    }
    
    func isFavorite(title: String, completionHandler: @escaping (_ response: Bool?, _ error: Error?) -> Void) {
        db.collection("favorites").whereField("title", isEqualTo: title).getDocuments() { (querySnapshot, err) in
            if let error = err {
                completionHandler(nil, error)
            } else {
                if let snapshot = querySnapshot {
                    if snapshot.documents.count > 0 {
                        completionHandler(true, nil)
                    } else {
                        completionHandler(false, nil)
                    }
                } else {
                    let error = NewsRequestError(message: "Favorites query was not successful.")
                    completionHandler(nil, error)
                }
            }
        }
    }
    
    func getFavorites(completionHandler: @escaping (_ response: [[String: Any]]?, _ error: Error?) -> Void) {
        db.collection("favorites").getDocuments() { (querySnapshot, err) in
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
    }
}
