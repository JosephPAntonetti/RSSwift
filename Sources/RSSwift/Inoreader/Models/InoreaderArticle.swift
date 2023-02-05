//
//  InoreaderArticle.swift
//  
//
//  Created by Joseph Antonetti on 2/5/23.
//

import Foundation
import InoreaderSwift

class InoreaderArticle : Article {

    private(set) var id: String
    private(set) var headline: String
    private(set) var body: String
    private(set) var url: URL?
    private(set) var imageUrl: URL?
    private(set) var publishDate: Date?
    private(set) var publisher: String?
    
    init(item: StreamContents.Item){
        id = item.id
        headline = item.title
        body = item.summary.content

        if let canonicalUrl =  item.canonical.first?.href {
            url = URL(string: canonicalUrl)
        }
        
        imageUrl = nil
        
        publishDate = nil
        publisher = nil
    }
}
