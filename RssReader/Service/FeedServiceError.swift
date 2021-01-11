//
//  FeedServiceError.swift
//  RssReader
//
//  Created by Tomoyuki Murakami on 2021/01/09.
//  Copyright © 2021 tomoyukim. All rights reserved.
//

import Foundation

enum FeedServiceError: Error {
    case invalidURL
    case responseError
    case parseError(Error)
}
