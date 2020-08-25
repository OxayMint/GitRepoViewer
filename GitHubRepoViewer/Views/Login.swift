//
//  Login.swift
//  GitHubRepoViewer
//
//  Created by OxayMint on 8/23/20.
//  Copyright © 2020 OxayInteractive. All rights reserved.
//

import SwiftUI

struct LoginView: View{
    var body: some View {
        VStack(spacing: 20){
            Text("Github Repo Viewer")
            Button(action: {
                GithubManager.shared.Login()
            }) {
                ZStack{
                    RoundedRectangle(cornerRadius: 5).frame(width:150, height: 55).foregroundColor(Color.gray)
                    HStack{
                        Spacer()
                        Image("github").resizable().frame(width:28,height: 28).foregroundColor(.black)
                        Spacer()
                        Text("Sign in").foregroundColor(.white)
                        Spacer()
                        }.padding().frame(width:150, height: 55)
                }
            }
        }
    }
}

