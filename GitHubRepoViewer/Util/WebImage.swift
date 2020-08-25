//
//  WebImage.swift
//  GitHubRepoViewer
//
//  Created by OxayMint on 8/24/20.
//  Copyright © 2020 OxayInteractive. All rights reserved.
//
import SwiftUI
import Combine
import Alamofire
struct WebImage: View{
    @ObservedObject var imageLoader: ImageLoader
    init(_ imgUrl: String) {
        imageLoader = ImageLoader(imgUrl)
    }
    var body : some View{
        Image(uiImage: imageLoader.data.count>0 ? UIImage(data: imageLoader.data)! :UIImage(named: "lock")!).resizable()
    }
    
}

class ImageLoader: ObservableObject {
    @Published var data: Data = Data()
    init(_ imgUrl: String) {
        guard let url = URL(string: imgUrl) else {
            return
        }
        AF.request(url).response{
            res in
            guard let data = res.data else{return}
            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}
