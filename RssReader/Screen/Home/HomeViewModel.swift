//
//  HomeViewModel.swift
//  RssReader
//
//  Created by Tomoyuki Murakami on 2021/01/09.
//  Copyright © 2021 tomoyukim. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

final class HomeViewModel: ObservableObject {
    // MARK: - Inputs
    enum Inputs {
        case onLoad
        case onTapItem(urlString: String)
    }
    
    // MARK: - Outputs
    @Published private(set) var articleCardInput: [ArticleCard.Input] = []
    @Published var isLoading = false
    @Published var isShowError = false
    
    init(feedService: FeedServiceType) {
        self.feedService = feedService
        self.bind()
        self.load("https://tomoyukim.hatenablog.com/feed")
    }

    func load(_ url: String) {
        onLoadSubject.send(url)
    }
    
    // MARK: - Private
    private let feedService: FeedServiceType
    private let onLoadSubject = PassthroughSubject<String, Never>()
    private let errorSubject = PassthroughSubject<FeedServiceError, Never>()
    private var cancellables: [AnyCancellable] = []
    
    private func bind() {
        let responseSubscriber = onLoadSubject.flatMap { [feedService] (url) in
            feedService.request(with: BlogFeedRequest(url: url))
                .catch { [weak self] error -> Empty<Feed, Never> in
                    self?.errorSubject.send(error)
                    return .init()
                }
        }
        .map { $0.entries }
        .sink(receiveValue: { [weak self] (entries) in
            guard let self = self else { return }
            self.articleCardInput = self.convertInput(entries: entries)
            self.isLoading = false
        })
        
        let loadingStartSubscriber = onLoadSubject
            .map { _ in true }
            .assign(to: \.isLoading, on: self)
        
        let errorSubscriber = errorSubject
            .sink(receiveValue: { [weak self] (error) in
                guard let self = self else { return }
                self.isShowError = true
                self.isLoading = false
            })
        
        cancellables += [
            responseSubscriber,
            loadingStartSubscriber,
            errorSubscriber
        ]
    }
    
    private func convertInput(entries: [Entry]) -> [ArticleCard.Input] {
        return entries.compactMap { (entry) -> ArticleCard.Input? in
            do {
                var htmlUrl: String?
                var coverImage: UIImage?
                for link in entry.links {
                    if link.type != nil {
                        guard let url = URL(string: link.href) else { return nil }
                        let data = try Data(contentsOf: url)
                        coverImage = UIImage(data: data)
                    } else {
                        htmlUrl = link.href
                    }
                }
                                
                guard let urlString = htmlUrl else { return nil }
                guard let image = coverImage else { return nil }
                                
                return ArticleCard.Input(
                    title: entry.title,
                    image: image,
                    summary: entry.summary,
                    date: entry.updated,
                    urlString: urlString,
                    feedTitle: "tomoyukim's blog")
            } catch {
                return nil
            }
        }
    }


}

