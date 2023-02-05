//
//  InoreaderRssClient.swift
//  
//
//  Created by Joseph Antonetti on 2/5/23.
//

import Foundation
import InoreaderSwift

class InoreaderRssClient : RssClient {
    
    private let api : InoreaderApi
    
    init(api: InoreaderApi) {
        self.api = api
    }
    
    func getFeeds() async -> [any Feed] {
        let result = await api.getSubscriptions()
        switch (result) {
        case .success(let subscriptions):
            return subscriptions.map({InoreaderFeed(apiClient: api, subscription: $0)})
        case .failure(_):
            return []
        }
    }
    
    func getFolders() async -> [any Folder] {
        return []
    }
}
