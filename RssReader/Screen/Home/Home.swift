//
//  Home.swift
//  RssReader
//
//  Created by Tomoyuki Murakami on 2021/01/08.
//  Copyright © 2021 tomoyukim. All rights reserved.
//

import SwiftUI

struct Home: View {
    @StateObject private var viewModel: HomeViewModel = .init(feedService: FeedService())
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                Text("Loading...")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .offset(x: 0, y: -200)
                    .navigationBarTitle("", displayMode: .inline)
            } else {
                ScrollView() {
                    LazyVStack(alignment: .leading) {
                        /* Section
                        HStack {
                            Text("Today")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(.blue)
                                .padding(.horizontal)
                                .padding(.vertical, 6)
                            Spacer()
                        }
                        */
                        ForEach(viewModel.articleCardInput) { input in
                            NavigationLink(
                                destination: WebView(url: URL(string: input.urlString)!),
                                label: {
                                    ArticleCard(input: input)
                                })
                            Divider()
                        }
                    }
                }
                .navigationBarTitle("Timeline", displayMode: .inline)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
