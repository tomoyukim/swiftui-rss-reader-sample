//
//  FeedService.swift
//  RssReader
//
//  Created by Tomoyuki Murakami on 2021/01/08.
//  Copyright © 2021 tomoyukim. All rights reserved.
//

import Foundation
import Combine
import XMLCoder

protocol FeedRequestType {
    associatedtype Response: Decodable
    
    var url: String { get }
}

protocol FeedServiceType {
    func request<Request>(with request: Request) -> AnyPublisher<Request.Response, FeedServiceError> where Request: FeedRequestType
}

final class FeedService: FeedServiceType {
    func request<Request>(with request: Request) -> AnyPublisher<Request.Response, FeedServiceError> where Request: FeedRequestType {
        let request = URLRequest(url: URL(string:request.url)!)
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, URLResponse in data }
            .mapError { _ in FeedServiceError.responseError }
            .decode(type: Request.Response.self, decoder: XMLDecoder())
            .mapError(FeedServiceError.parseError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
