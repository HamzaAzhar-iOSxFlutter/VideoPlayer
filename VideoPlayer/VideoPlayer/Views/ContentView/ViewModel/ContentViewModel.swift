//
//  ContentViewModel.swift
//  VideoPlayer
//
//  Created by Hamza Azhar on 18/06/2022.
//

import SwiftUI
import AVFoundation

extension ContentView {
    
    class ViewModel: ObservableObject {
        @Published var videosData: Videos?
        
        @Published var selectedQuery: QueryTypes = .nature {
            didSet {
                if #available(iOS 15.0, *) {
                    Task.init {
                       await self.fetchVideoRequest(searchQuery: selectedQuery.rawValue)
                    }
                } else {
                    self.postFetchVideoRequest(searchQuery: selectedQuery.rawValue) { status in
                        self.validateResponse(status: status)
                    }
                }
            }
        }
        
        init() {
            if #available(iOS 15.0, *) {
                Task.init {
                    await self.fetchVideoRequest(searchQuery: selectedQuery.rawValue)
                }
            } else {
                self.postFetchVideoRequest(searchQuery: selectedQuery.rawValue) { status in
                    self.validateResponse(status: status)
                }
            }
        }
        
        func postFetchVideoRequest(searchQuery: String, completion: @escaping (Bool) -> ()) {
            guard let url = URL(string: Environment.baseURL + "?query=\(searchQuery)&per_page=1") else { fatalError("Missing URL") }
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue(Environment.apiKey, forHTTPHeaderField: "Authorization")
            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest) { data, response, error in
                guard let dataReceived = data else { return }
                guard let videos = try? JSONDecoder().decode(Videos.self, from: dataReceived) else {
                    print("unable to parse data")
                    return
                }

                DispatchQueue.main.async {
                    self.videosData = nil
                    self.videosData = videos
                }
                completion(true)
            }
            task.resume()
        }
        
        func validateResponse(status: Bool) {
            switch status {
            case true:
                break
            case false:
                break
            }
        }
        
        @available(iOS 15.0.0, *)
        func fetchVideoRequest(searchQuery: String) async {
            do {
                guard let url = URL(string: Environment.baseURL + "?query=\(searchQuery)&per_page=1") else { fatalError("Missing URL") }
                print(url)
                var urlRequest = URLRequest(url: url)
                urlRequest.setValue(Environment.apiKey, forHTTPHeaderField: "Authorization")
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try decoder.decode(Videos.self, from: data)
                
                DispatchQueue.main.async {
                    self.videosData = nil
                    self.videosData = decodedData
                    
                }
            } catch {
                print(error)
            }
        }
    }
}
