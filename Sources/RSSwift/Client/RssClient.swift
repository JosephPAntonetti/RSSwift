//
//  RssClient.swift
//  
//
//  Created by Joseph Antonetti on 2/5/23.
//

import Foundation

protocol RssClient {
    
    func getFeeds() async -> [any Feed]
    func getFolders() async -> [any Folder]

}
