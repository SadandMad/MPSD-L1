//
//  UnitViewModel.swift
//  MPSD L1
//
//  Created by Евгений on 21/5/21.
//

import Foundation
import FirebaseFirestore

class unitViewModel: ObservableObject {
    private let db = Firestore.firestore()
    @Published var units = [Unit]()
    @Published var authUnit: Unit? = nil
    
    func getUnits() {
        db.collection("units").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.objectWillChange.send()
                self.units.removeAll()
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let shortDesk = data["shortDesk"] as? String ?? ""
                    let longDesk = data["longDesk"] as? String ?? ""
                    let price = data["price"] as? UInt ?? 5
                    let isFavourite = data["isFavourite"] as? Bool ?? false
                    let category = data["category"] as? String ?? ""
                    let latitude = data["latitude"] as? Double ?? 53.9122
                    let longitude = data["longitude"] as? Double ?? 27.5944
                    let imageName = data["imageName"] as? String ?? nil
                    let videoName = data["videoName"] as? String ?? nil
                    let refId = document.documentID
                    let newUnit = Unit(name: name, shortDesk: shortDesk, longDesk: longDesk, price: price, isFavourite: isFavourite, category: category, latitude: latitude, longitude: longitude, imageName: imageName, videoName: videoName, refId: refId)
                    self.units.append(newUnit)
                }
            }
        }
        print("Got units")
    }
    
    func addUnit(name: String, price: UInt, shortDesk: String, longDesk: String, isFavourite: Bool, category: String,
                 latitude: Double, longitude: Double, imageName: String) {
        var ref: DocumentReference? = nil
        ref = db.collection("units").addDocument(data: [
            "name": name,
            "price": price,
            "shortDesk": shortDesk,
            "longDesk": longDesk,
            "isFavourite": isFavourite,
            "category": category,
            "latitude": latitude,
            "longitude": longitude,
            "imageName": imageName
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.getUnits()
            }
        }
    }
    
    func deleteUnit(id: String) {
        db.collection("units").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document \(id) successfully removed!")
            }
        }
        self.getUnits()
    }
    
    func unitAuth(login: String, password: String) -> Bool {
        for unit in self.units {
            if (unit.name == login && String(unit.price) == password) {
                authUnit = unit
                return true
            }
        }
        return false
    }
    
    func updateUnit(ref: String, price: UInt, image: String) {
        let unitRef = db.collection("units").document(ref)

        unitRef.updateData([
            "price": price,
            "imageName": image
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                self.authUnit!.price = price
                self.authUnit!.imageName = image
                print("Document successfully updated")
            }
        }
    }
    
    func filterUnits(type: Int, filter: String) {
        switch type {
        case 0:
            let filteredUnits = self.units.filter({$0.name.contains(filter)})
            units = filteredUnits
        case 1:
            let filteredUnits = self.units.filter({$0.price <= Int(filter) ?? 100})
            units = filteredUnits
        case 2:
            let filteredUnits = self.units.filter({$0.price >= Int(filter) ?? 0})
            units = filteredUnits
        case 3:
            let filteredUnits = self.units.filter({$0.category == filter})
            units = filteredUnits
        case 4:
            let filteredUnits = self.units.filter({$0.isFavourite == Bool(filter)})
            units = filteredUnits
        default:
            print("Wrong filter type: \(type)")
        }
    }
}
