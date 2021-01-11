//
//  Article.swift
//  RssReader
//
//  Created by Tomoyuki Murakami on 2021/01/09.
//  Copyright © 2021 tomoyukim. All rights reserved.
//

import Foundation

struct Article: Decodable, Hashable, Identifiable {
    let id: String
    let title: String
    let summary: String
    let content: String
    let updated: String
    let link: String
    let imageURL: String
}
