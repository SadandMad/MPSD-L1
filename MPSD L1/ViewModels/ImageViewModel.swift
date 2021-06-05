//
//  ImageViewModel.swift
//  MPSD L1
//
//  Created by Евгений on 26/5/21.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseStorage
import Combine

class imageViewModel: ObservableObject {
    private let imagesRef = Storage.storage().reference().child("Img")
    @Published var image: UIImage?
    
    func getImage(name: String) {
        imagesRef.child(name).getData(maxSize: 1 * 1024 * 1024) { data, err in
            if let err = err {
                print("Error getting documents: \(err)")
                self.image = nil
            } else {
                self.image = UIImage(data: data!)
            }
        }
    }
}
