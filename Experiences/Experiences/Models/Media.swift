//
//  Media.swift
//  Experiences
//
//  Created by Joe Veverka on 7/10/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation

//MARK: - Public Media Properties

enum MediaType: String, CaseIterable {
    case audio = "Audio"
    case video = "Video"
    case image = "Image"
    static let types: [String] = ["Audio", "Video", "Image"]
}

class Media {
    
    //MARK: - Properties
    
    let mediaType: MediaType
    var mediaURL: URL?
    var mediaData: Data?
    let createdDate: Date
    var updatedDate: Date?
    
    //MARK: - Inits
    
    init (mediaType: MediaType, url: URL?, data: Data? = nil, date: Date = Date()) {
        self.mediaType = mediaType
        self.mediaData = data
        self.mediaURL = url
        self.createdDate = date
    }
}

