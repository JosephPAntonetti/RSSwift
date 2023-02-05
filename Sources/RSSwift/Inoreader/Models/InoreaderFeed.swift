//
//  InoreaderSubscription.swift
//  
//
//  Created by Joseph Antonetti on 2/5/23.
//

import Foundation
import InoreaderSwift

class InoreaderFeed : Feed {
    
    public private(set) var id: String
    public private(set) var label: String
    public private(set) var iconURL: URL?
    
    private let apiClient : InoreaderApi
    
    init(apiClient: InoreaderApi, subscription: Subscription) {
        self.apiClient = apiClient
        
        self.id = subscription.id
        self.label = subscription.title
        if let urlString = subscription.iconUrl {
            self.iconURL = URL(string: urlString)
        } else {
            self.iconURL = nil
        }
    }
    
    func getArticles() async -> [any Article] {
        let result = await apiClient.getStreamContents(streamID: id)
        switch (result) {
        case .success(let streamContent):
            return streamContent.items.map({InoreaderArticle(item: $0)})
        case .failure(_):
            return []
        }
    }
}
