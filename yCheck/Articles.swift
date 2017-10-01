//
//  Articles.swift
//  yCheck
//
//  Created by Hint Desktop on 01/10/2017.
//  Copyright © 2017 Yacine.M. All rights reserved.
//

import Foundation
import UIKit

class Articles: Codable {
    let author: String
    let title: String
    let description: String
    let publishedAt: String
    let url: String
    
    init(author: String, title: String, description: String, publishedAt: String, url: String) {
        self.author = author
        self.title = title
        self.description = description
        self.publishedAt = publishedAt
        self.url = url
    }
}

class ArticlesList: Codable {
    let articles: [Articles]
    
    init(articles: [Articles]) {
        self.articles = articles
    }
}
