//
//  Article.swift
//  RSSReader Watch App
//
//  Created by Joseph Antonetti on 2/2/23.
//

import Foundation

public protocol Article : Identifiable {
    
    var id : String { get }
    var headline : String { get }
    var body : String { get }
    var url : URL? { get }
    var imageUrl : URL? { get }
    var publishDate : Date? { get }
    var publisher : String? { get }

}
