//
//  Entry.swift
//  RssReader
//
//  Created by Tomoyuki Murakami on 2021/01/09.
//  Copyright © 2021 tomoyukim. All rights reserved.
//

import Foundation

struct Entry: Decodable, Hashable, Identifiable {
    let id: String
    let title: String
    let summary: String
    let content: String
    let updated: String
    let published: String
    let links: [Link]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case summary
        case content
        case updated
        case published
        case links = "link"
    }
}
