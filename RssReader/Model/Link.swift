//
//  Link.swift
//  RssReader
//
//  Created by Tomoyuki Murakami on 2021/01/09.
//  Copyright © 2021 tomoyukim. All rights reserved.
//

import Foundation
import XMLCoder

struct Link: Decodable, DynamicNodeEncoding, Hashable, Identifiable {
    let id: UUID = UUID()
    let href: String
    let type: String?
    let value: String
    
    enum CodingKeys: String, CodingKey {
            case href
            case type
            case value = ""
        }
    
    static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        switch key {
        case CodingKeys.href:
            return .attribute
        case CodingKeys.type:
            return .attribute
        default:
            return .element
        }
    }
}
