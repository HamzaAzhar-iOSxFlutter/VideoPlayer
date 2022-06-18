//
//  Models.swift
//  VideoPlayer
//
//  Created by Hamza Azhar on 18/06/2022.
//

import Foundation

enum QueryTypes: String, CaseIterable {
   case nature, animals, people, ocean, food
}


struct Videos: Decodable {
    let page, perPage, totalResults: Int?
    let url: String?
    let videos: [Video]?
}

// MARK: - Video
struct Video: Identifiable, Decodable {
    let id:  Int?
    let url: String?
    let image: String?
    let duration: Int?
    let user: User?
    let videoFiles: [VideoFile]?
    
    struct User: Identifiable, Decodable {
        let id: Int?
        let name: String?
        let url: String?
    }
    
    struct VideoFile: Identifiable, Decodable  {
        let id: Int?
        let quality, fileType: String?
        let link: String?
    }

}
