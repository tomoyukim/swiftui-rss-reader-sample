//
//  Home.swift
//  RssReader
//
//  Created by Tomoyuki Murakami on 2021/01/08.
//  Copyright © 2021 tomoyukim. All rights reserved.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
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
                    // TODO: foreach
                    NavigationLink(
                        destination: WebView(url: URL(string: "https://tomoyukim.hatenablog.com/entry/2020/09/14/225701")!),
                        label: {
                            ArticleCard(input: .init(title: "aaa", image: UIImage(named: "coverImage")!, summary: "aaa", date: "2020-09-14T22:57:01+09:00", feedTitle: "tomoyukim's blog"))
                        })
                    Divider()
                }
            }
            .navigationBarTitle("Timeline", displayMode: .inline)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
