//
//  NewCellViewModel.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 03/12/20.
//

import Foundation

class NewCellViewModel: ObservableObject {
    var isFavorite = false;
    let new: New;
    
    init (new: New) {
        self.new = new;
    }
    
    func favorite() {
        
    }
}
