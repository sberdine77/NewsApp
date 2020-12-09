//
//  New.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 02/12/20.
//

import Foundation

struct New: Identifiable, Decodable, Equatable {
    var id = UUID();
    let title: String;
    let description: String;
    let content: String;
    let author: String;
    let publishedAt: Date;
    let highlight: Bool;
    let url: String;
    let image_url: String;
}
