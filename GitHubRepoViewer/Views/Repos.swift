//
//  Repos.swift
//  GitHubRepoViewer
//
//  Created by OxayMint on 8/23/20.
//  Copyright © 2020 OxayInteractive. All rights reserved.
//

import SwiftUI


struct ReposView: View{
    @EnvironmentObject var env: GlobalEnvironment
    let id: String
    let filter: String
    init(_ listId: String, _ f: String = "") {
        id = listId
        filter = f
    }
    var body: some View{
        guard let list = self.env.state.repoLists[id] else{
            return AnyView(Text(""))
        }
        return AnyView(List(list.filter({r in r.name.lowercased().starts(with: self.filter.lowercased())})){ repo in
            VStack{
                HStack{
                    Image(repo.fork ? "fork" : "repo").resizable().frame(width:20,height: 20)
                    VStack(alignment:.leading){
                        Text(repo.name).font(.headline)
                        Text(repo.githubRepoDescription ?? "").font(.caption)
                        Text("Language: \(repo.language ?? "n/a")").font(.footnote)
                    }
                }
                
            }
        }.listStyle(GroupedListStyle()))
    }
}

