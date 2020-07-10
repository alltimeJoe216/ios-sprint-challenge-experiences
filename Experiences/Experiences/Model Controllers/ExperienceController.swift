//
//  ExperienceController.swift
//  Experiences
//
//  Created by Joe Veverka on 7/10/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation
import MapKit

class ExperienceController {
    
    //MARK: - Properties
    
    var experiences: [Experience] = []
    
    //MARK: - Class Funcs
    
    func add(newExperience: Experience) {
        experiences.append(newExperience)
    }
    
    func update(experience: Experience, title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        
    }
    
}
