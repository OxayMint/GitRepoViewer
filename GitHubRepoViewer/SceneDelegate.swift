//
//  SceneDelegate.swift
//  GitHubRepoViewer
//
//  Created by OxayMint on 8/22/20.
//  Copyright © 2020 OxayInteractive. All rights reserved.
//

import UIKit
import SwiftUI
import Alamofire
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {return}
        
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
         let params = components.queryItems else {
                print("Invalid URL")
            return
        }
        
        guard let code = params.first(where: { $0.name == "code" })?.value
        else {
            print("code missing")
            return
        }
        GithubManager.shared.GetAccessToken(code)
    }
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let env = GlobalEnvironment()
        GithubManager.shared.setGlobalEnvironment(env)
        let contentView = ContentView().environmentObject(env)
        
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
        
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
}


struct SceneDelegate_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
