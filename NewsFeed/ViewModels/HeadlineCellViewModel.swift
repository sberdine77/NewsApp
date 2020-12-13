//
//  HeadlineCellViewModel.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 03/12/20.
//

import Foundation

class HeadlineCellViewModel: ObservableObject {
    let firebaseFavoriteNewsService = FirebaseFavoriteNewsService()
    @Published var isFavorite = false;
    @Published var buttonDisabled: Bool = false;

    let new: New;
    
    init (new: New) {
        self.new = new;
        firebaseFavoriteNewsService.isFavorite(title: new.title) { (isFav, err) in
            if let error = err {
                print("Error initializing favorite button: \(error)")
                self.isFavorite = false
                self.buttonDisabled = true
            } else {
                if let control = isFav {
                    self.isFavorite = control
                } else {
                    print("Error initializing favorite button")
                    self.isFavorite = false
                    self.buttonDisabled = true
                }
            }
        }
    }
    
    func favorite() {
        firebaseFavoriteNewsService.isFavorite(title: new.title) { (isFav, err) in
            if let error = err {
                print("Error favoriting new: \(error)")
            } else {
                if let control = isFav {
                    if control {
                        self.isFavorite = true
                    } else {
                        self.isFavorite = false
                    }
                    
                    if self.isFavorite {
                        self.unFavorite()
                    } else {
                        self.firebaseFavoriteNewsService.addFavorite(favorite: self.encodeNewsOrHighlights(newOrHighlight: self.new)) { (result, err) in
                            if let error = err {
                                print("Error favoriting new: \(error)")
                            } else {
                                print(result ?? "Success")
                                self.isFavorite = true
                                self.buttonDisabled = false
                            }
                        }
                    }
                    
                } else {
                    print("Error favoriting new.")
                }
            }
        }
    }
    
    func unFavorite() {
        firebaseFavoriteNewsService.removeFavorite(title: new.title) { (response, err) in
            if let error = err {
                print("Error unfavoriting new: \(error)")
            } else {
                print(response ?? "Success")
                self.isFavorite = false
                self.buttonDisabled = false
            }
        }
    }
    
    func encodeNewsOrHighlights(newOrHighlight: New) -> [String: Any] {
        
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let createdDate = dateFormatter.string(from: newOrHighlight.publishedAt)
        
        let result = [
            "title": newOrHighlight.title,
            "description": newOrHighlight.description,
            "content": newOrHighlight.content,
            "author": newOrHighlight.author,
            "published_at": createdDate,
            "highlight": newOrHighlight.highlight,
            "url": newOrHighlight.url,
            "image_url": newOrHighlight.image_url
        ] as [String : Any]
        
        return result
        
    }
}
