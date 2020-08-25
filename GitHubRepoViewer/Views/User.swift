//
//  User.swift
//  GitHubRepoViewer
//
//  Created by OxayMint on 8/23/20.
//  Copyright © 2020 OxayInteractive. All rights reserved.
//

import SwiftUI
//import SDWebImageSwiftUI

struct UserView: View{
    let userLogin: String
    @EnvironmentObject var env: GlobalEnvironment
    init(_ login: String) {
        userLogin = login
    }
    
    var body: some View {
        containedView()
    }
    
    func containedView() -> AnyView {
        if let user = env.state.userLists[self.userLogin]{
            return AnyView(VStack(alignment: .leading){
                UserInfo(user)
                ReposView(user.login)
                Spacer()
            })
        }else{
            return AnyView(Text("Loading user"))
        }
    }
}


struct UserInfo: View {
    let user: GithubUser
    init(_ gUser: GithubUser) {
        user = gUser
    }
    var body: some View{
        HStack{
            WebImage(user.avatarURL).frame(width: 50, height: 50).padding()
            VStack(alignment:.leading){
                Text(user.login).font(.headline)
                HStack{
                    Image(systemName: "envelope.circle.fill")
                    Text(user.email!).font(.footnote)
                }
                
                HStack{ Image(systemName: "location.circle.fill")
                    Text(user.location!).font(.footnote)}
            }
            Spacer()
            Button(action: {
                GithubManager.shared.Logout()
            }) {
                Image("logout").resizable().frame(width:25,height:25).foregroundColor(.primary)
            }
            Spacer()
        }
        
        
    }
}
