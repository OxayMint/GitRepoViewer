//
//  Environment.swift
//  GitHubRepoViewer
//
//  Created by OxayMint on 8/23/20.
//  Copyright © 2020 OxayInteractive. All rights reserved.
//

import Combine

class GlobalEnvironment: ObservableObject{
   @Published var state = GithubState()
   init() {

   }
}


struct GithubState: Decodable {
    init() {
        userLists = [:]
        repoLists = [:]
    }
    var currentUser: GithubUser?
    var userLists : [String: GithubUser]
    var repoLists : [String: [GithubRepo]]
}
