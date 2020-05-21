//
//  DBManageAllMovies.swift
//  MinionMovies
//
//  Created by Vitor Costa on 20/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation
import RealmSwift

protocol DBManagerProtocol {
    func add(object: Object)
    func delete(object: Object)
    func check(objectId: String, type: Object.Type) -> Bool
    func retrieveSpecificItem(objectId: String, type: Object.Type) -> Object
}

enum ConfigurationType {
    case basic
    case inMemory
}

class DBManager {
    
    var config = Realm.Configuration()
    let realm = try! Realm()
    
    init(config: ConfigurationType) {
        switch config {
        case .basic:
            self.config = Realm.Configuration()
        case .inMemory:
            self.config = Realm.Configuration(inMemoryIdentifier: "inMemory")
        }
    }
    
    func add(object: Object) {
        do {
            
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func delete(object: Object) {
        do {
            
            try realm.write{
                realm.delete(object)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func check(objectId: String, type: Object.Type) -> Bool {
        let objects = realm.objects(type).filter("id == '\(objectId)'")
        
        return objects.count > 0
    }
    
    func retrieveSpecificItem(objectId: String, type: Object.Type) -> Object {
        let objects = realm.objects(type).filter("id = '\(objectId)'")
        
        return objects.first!
    }
    
    func retrieveAllObjects(type: Object.Type) -> [Object] {
        var allObjects: [Object] = []
        let realmResults = realm.objects(type)
        
        for object in realmResults {
            allObjects.append(object)
        }
        
        return allObjects
    }
}
