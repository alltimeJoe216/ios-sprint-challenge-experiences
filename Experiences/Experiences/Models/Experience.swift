//
//  Experience.swift
//  Experiences
//
//  Created by Joe Veverka on 7/10/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation
import MapKit

class Experience: NSObject, MKAnnotation {
    
    //MARK: - Properties
    
    var title: String?
    var subtitle: String?
    var media: [Media] = []
    
    /// Location relevant
    var coordinate: CLLocationCoordinate2D
    
    /// Date relevant
    var createdTimeStamp: Date
    var updatedTimeStamp: Date?
    
    //MARK: - Inits
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, createdDate: Date = Date()) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.createdTimeStamp = createdDate
    }
    
    //MARK: - Model Funcs
    
    func addMedia(mediaType: MediaType, url: URL?, data: Data? = nil)  {
        media.append(Media(mediaType: mediaType, url: url, data: data))
        
    }
    
    func addMedia(media: Media) {
        self.media.append(media)
    }
    
}
