//
//  RssReaderApp.swift
//  RssReader
//
//  Created by Tomoyuki Murakami on 2021/01/07.
//

import SwiftUI

@main
struct RssReaderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Home()
            /*
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
 */
        }
    }
}
