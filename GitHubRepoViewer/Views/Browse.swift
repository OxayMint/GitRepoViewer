//
//  Browse.swift
//  GitHubRepoViewer
//
//  Created by OxayMint on 8/24/20.
//  Copyright © 2020 OxayInteractive. All rights reserved.
//

import SwiftUI
import Combine
struct BrowseView: View{
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    @EnvironmentObject var env: GlobalEnvironment
    var body: some View{
        VStack{
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("search", text: $searchText, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                    }, onCommit: {
                        GithubManager.shared.SearchRepo(self.searchText)
                    }).foregroundColor(.primary)
                    
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
                
                if showCancelButton  {
                    Button("Cancel") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        //                        UIApplication.shared. // this must be placed before the other commands here
                        self.searchText = ""
                        self.showCancelButton = false
                    }
                    .foregroundColor(Color(.systemBlue))
                }
            }
            .padding(.horizontal)
                .navigationBarHidden(showCancelButton) // .animation(.default) // animation does not work properly
            
            ReposView("search_items", searchText)
            Spacer()
        }
    }
}
