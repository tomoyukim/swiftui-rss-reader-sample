//
//  Feed.swift
//  RssReader
//
//  Created by Tomoyuki Murakami on 2021/01/09.
//  Copyright © 2021 tomoyukim. All rights reserved.
//

import Foundation

struct Feed: Decodable, Hashable, Identifiable {
    let id: String
    let title: String
    let link: Link
    let updated: String
    let author: String
    let entries: [Entry]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case link
        case updated
        case author
        case entries = "entry"
    }
}
