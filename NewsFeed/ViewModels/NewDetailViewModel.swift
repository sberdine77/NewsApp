//
//  NewDetailViewModel.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 03/12/20.
//

import Foundation

class NewDetailViewModel: ObservableObject {
    let new: New;
    
    init (new: New) {
        self.new = new;
    }
    
}
