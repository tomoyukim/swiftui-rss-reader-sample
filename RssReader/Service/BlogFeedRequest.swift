//
//  BlogFeedRequest.swift
//  RssReader
//
//  Created by Tomoyuki Murakami on 2021/01/09.
//  Copyright © 2021 tomoyukim. All rights reserved.
//

import Foundation

struct BlogFeedRequest: FeedRequestType {
    typealias Response = Feed

    var url: String
}
