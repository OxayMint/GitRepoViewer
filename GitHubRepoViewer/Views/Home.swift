//
//  Home.swift
//  GitHubRepoViewer
//
//  Created by OxayMint on 8/22/20.
//  Copyright © 2020 OxayInteractive. All rights reserved.
//

import SwiftUI
//import SDWebImageSwiftUI
struct HomeView: View{
    @State private var selection = 1

    @EnvironmentObject var env: GlobalEnvironment
    var body: some View{
        TabView(selection: $selection){
            BrowseView()
            .tabItem{
                Image(systemName: "magnifyingglass")
                Text("Browse")
            }.tag(0)
            UserView(env.state.currentUser!.login)
            .tabItem{
                Image(systemName: "person")
                Text(env.state.currentUser?.login ?? "User")
            }.tag(1)
        }
    }
}
