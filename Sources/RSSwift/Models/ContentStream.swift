//
//  File.swift
//  
//
//  Created by Joseph Antonetti on 2/2/23.
//

import Foundation

public protocol ContentStream : Identifiable {
    
    var id : String { get }
    var label : String { get }
    
    func getArticles() async -> [any Article]

}
