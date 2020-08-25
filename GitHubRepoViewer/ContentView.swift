//
//  ContentView.swift
//  GitHubRepoViewer
//
//  Created by OxayMint on 8/22/20.
//  Copyright © 2020 OxayInteractive. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject private var env: GlobalEnvironment
    var body: some View {
        env.state.currentUser == nil ? AnyView(LoginView()) : AnyView(HomeView())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
