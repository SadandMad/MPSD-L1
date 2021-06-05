//
//  Unit.swift
//  MPSD L1
//
//  Created by Евгений on 21/5/21.
//

import Foundation
import SwiftUI
import MapKit

struct Unit: Identifiable{
    var id: String = UUID().uuidString
    var name: String = ""
    var shortDesk: String = ""
    var longDesk: String = ""
    var price: UInt = 0
    var isFavourite: Bool = false
    var category: String = ""
    var latitude: Double = 53.9122
    var longitude: Double = 27.5944
    var imageName: String? = nil
    var videoName: String? = nil
    var refId: String = ""
    
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}
