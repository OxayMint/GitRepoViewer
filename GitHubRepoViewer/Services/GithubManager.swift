//
//  GithubManager.swift
//  GitHubRepoViewer
//
//  Created by OxayMint on 8/22/20.
//  Copyright © 2020 OxayInteractive. All rights reserved.
//

import Alamofire
import SwiftUI
import Combine
class GithubManager: ObservableObject{
    
    final let client_id = "Iv1.0f76b238e5374577"
    final let client_secret = "cd7d76fdffb22dea8a99e89e08b54baa846dfdb7"
    let apiRoot = "https://api.github.com"
    let loginUrl = URL(string: "https://github.com/login/oauth/authorize?client_id=Iv1.0f76b238e5374577")!
    
    let getAccessTokeUrl = "https://github.com/login/oauth/access_token"
    
    var access_token: String?
    static let shared = GithubManager()

    private init() {
        
    }
    
    var globalEnvironment = GlobalEnvironment()
    
    public func setGlobalEnvironment(_ env: GlobalEnvironment){
        self.globalEnvironment = env
    }
    
    func header()-> HTTPHeaders{
        return [
            "Authorization": "token \(self.access_token!)",
            "Accept": "application/json"
        ]
    }
    
    public func CheckToken() -> Bool{
        if let token = UserDefaults.standard.string(forKey: "access_token"){
            self.access_token = token
            GetMyUser()
            return true
        }
        return false
    }
    
    public func Login(){
        if self.CheckToken(){
            return
        }
        UIApplication.shared.open(loginUrl)
    }
    public func GetAccessToken(_ code: String){
        let params = ["code": code, "client_secret":client_secret, "client_id":client_id]
        AF.request(self.getAccessTokeUrl, parameters: params).response{response in
            let responseString = String(data:response.data!, encoding: .utf8)
            guard let token = responseString?.split(separator: "&").first(where: {$0.starts(with: "access_token")} )?.replacingOccurrences(of: "access_token=", with: "") else{
                return
            }
            self.SetToken(token)
            self.globalEnvironment.state.repoLists["search_items"] = []
            self.GetMyUser()
        }
    }
    
    
    
    public func GetMyUser(){
        AF.request("\(apiRoot)/user", headers: header()).responseJSON{ res in
            guard let user = try? JSONDecoder().decode(GithubUser.self, from: res.data!)else{
                self.Logout()
                return
            }
            DispatchQueue.main.async {
                self.globalEnvironment.state.userLists[user.login] = user
                self.globalEnvironment.state.currentUser = user
                self.GetMyRepos()
            }
        }
    }
    
    public func GetMyRepos(){
        guard let login = self.globalEnvironment.state.currentUser?.login else {return}
        GetRepos(login)
    }
    
    public func GetRepos(_ login: String){
        let urlString = "\(apiRoot)/users/\(login)/repos"
        AF.request(urlString, headers: header()).response{res in
            guard let repos = try? JSONDecoder().decode([GithubRepo].self, from: res.data!)else{
                return
            }
            DispatchQueue.main.async {
                self.globalEnvironment.state.repoLists[login] = repos
            }
        }
    }
    
    public func SearchRepo(_ txt: String){
        AF.request("\(apiRoot)/search/repositories?q=\(txt)", headers: header()).response{res in
            guard let searchResult = try? JSONDecoder().decode(SearchResult.self, from: res.data!)else{return}
            
            DispatchQueue.main.async {
                self.globalEnvironment.state.repoLists["search_items"] = searchResult.items
            }
        }
    }
    
    public func Logout(){
        self.SetToken(nil)
        self.globalEnvironment.state.currentUser = nil
    }
    
    public func SetToken(_ token: String?){
        self.access_token = token
        UserDefaults.standard.set(token, forKey: "access_token")
    }
}

